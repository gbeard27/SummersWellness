#
#  lambda_function.py
#  SummersWellnessFarm
#
#  Created by Grace Beard on 3/26/25.
#
# RENAME TO lambda_function.py
import json
import os
import openai
import traceback

def get_api_key():
    print("[DEBUG] Retrieving OpenAI API key...")
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("API Key not found in environment variables.")
    return api_key

def generate_prompt(body):
    print(f"[DEBUG] Constructing prompt from body: {body}")

    # Retrieve optional values, converting to string or "nil" if not provided.
    steps = body.get("steps")
    calories_value = body.get("calories")
    hours_of_sleep = body.get("hoursOfSleep")
    stepsStr = str(steps) if steps is not None else "nil"
    caloriesStr = str(calories_value) if calories_value is not None else "nil"
    sleepStr = str(hours_of_sleep) if hours_of_sleep is not None else "nil"

    profile = f"""User Profile:
- Age: {body['age']}
- Gender: {body['gender']}
- Height: {body['height']} inches
- Weight: {body['weight']} lbs
- Steps: {stepsStr}
- Known Calories Burned: {caloriesStr}
- Hours of Sleep: {sleepStr}"""

    meals = "\n".join(
        f"- {meal}: {desc}" for meal, desc in body.get("meals", {}).items()
    ) or "None"

    activities = "\n".join(
        f"- {a['name']} for {a['duration']} min ({a['intensity']})"
        for a in body.get("activities", [])
    ) or "None"

    prompt = f"""{profile}

Meals:
{meals}

Activities:
{activities}

Please estimate the total calories consumed from the meals and burned during the activities. Then calculate the net calorie balance for the day, and provide a short summary or advice.
"""
    print(f"[DEBUG] Final generated prompt:\n{prompt}")
    return prompt


def lambda_handler(event, context):
    print("=== LAMBDA FUNCTION START ===")

    try:
        print(f"[DEBUG] Raw event: {json.dumps(event)}")

        body_str = event.get("body", "")
        print(f"[DEBUG] Body string: {body_str}")

        body = json.loads(body_str)
        print(f"[DEBUG] Parsed body: {body}")

        prompt = generate_prompt(body)

        openai.api_key = get_api_key()
        print("[DEBUG] Calling OpenAI...")

        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": "You are a fitness assistant who can analyze meals and workouts to estimate calorie balance."},
                {"role": "user", "content": prompt}
            ]
        )

        print(f"[DEBUG] OpenAI raw response: {response}")
        message = response["choices"][0]["message"]["content"].strip()

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"recommendation": message})
        }

    except Exception as e:
        error_details = traceback.format_exc()
        print(f"[ERROR] Exception occurred:\n{error_details}")
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": str(e), "trace": error_details})
        }
