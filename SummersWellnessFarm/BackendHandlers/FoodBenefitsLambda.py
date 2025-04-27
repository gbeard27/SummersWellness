#
#  lambda_function.py
#  SummersWellnessFarm
#
#  Created by Grace Beard on 3/27/25.
#
# RENAME TO lambda_function.py
import json
import os
import subprocess
import openai
import sys
sys.path.append("/var/task")

def get_api_key():
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        print("[DEBUG] API Key not found in environment variables.")
        raise ValueError("API Key not found! Ensure it is set in AWS Lambda environment variables.")
    print('[DEBUG] API Key successfully retrieved')
    return api_key
  
def generate_prompt(user_preferences):
    """Generate AI prompt based on user preferences and activities."""
    try:
        return (
            f"- List of User Food Selections: {user_preferences}.\n"
            "Based on the user's selections, create a summary of the benefits of eating each food."
        )
    except Exception as e:
        print(f"[ERROR] Failed to generate prompt: {e}")
        return "The user has preferences."


def lambda_handler(event, context):
    print("[DEBUG] Lambda function triggered.")
    print(f"[DEBUG] Event Recieved: {event}")

    try:
        body = json.loads(event["body"])
        print(f"[DEBUG] Parsed event body: {body}")

        user_preferences = body.get("preferences", [])
        print(f"[DEBUG] Extracted preferences: {user_preferences}")

        user_input = generate_prompt(user_preferences)
        print(f"[DEBUG] Final prompt:\n{user_input}")

        openai.api_key = get_api_key()
        print("[DEBUG] API Key successfully retrieved")
        print("[DEBUG] Calling OpenAI API")

        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": user_input}
            ]
        )
        print(f"[DEBUG] OpenAI API raw response: {response}")

        # Defensive check to ensure response is structured as expected
        choices = response.get("choices")
        if not choices or not choices[0].get("message") or not choices[0]["message"].get("content"):
            raise ValueError("OpenAI response missing 'content' field.")

        recommendation = choices[0]["message"]["content"].strip()

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"recommendation": recommendation})
        }

    except Exception as e:
        print(f"[ERROR] Exception occurred: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
