# 🌿 Summers Wellness Farm App

This app provides a personalized, health-focused experience for guests at Summers Wellness Farm, including wellness tracking, activity booking, event planning, and AI-powered recommendations.

---
# 📚 Table of Contents
- [Pages and Their Purpose](#-pages-and-their-purpose)
- [AWS Lambda Setup Instructions](#-aws-lambda-setup-instructions)
- [How to Create an OpenAI API Key](#-how-to-create-an-openai-api-key)
- [Common AWS Setup Errors and Fixes](#-common-aws-setup-errors-and-fixes)
- [System Flow Overview](#-system-flow-overview)
- [Billing Reminders](#-billing-reminders)
- [Deployment Final Checklist](#-deployment-final-checklist)
---

# 📚 Pages and Their Purpose

| File | Purpose |
|:----|:--------|
| **BookActivities** | Browse and book activities (e.g., Yoga, Farm Tour) organized by category. |
| **BookMealView** | Book reservations for farm-to-table meals. |
| **BookTour** | Book tours around the farm property. |
| **CalorieCalc** | Submit food and activity data for personalized calorie recommendations (connected to AWS Lambda). |
| **ContentView** | Main entry screen navigating to Guest, Wedding, or Corporate Dashboards. |
| **CorporateDashboard** | Dashboard for corporate event planning and group activity booking. |
| **Dashboard** | Guest dashboard showing personal info, booked activities, food dashboard, smartwatch integration. |
| **DashboardViewModel** | Manages logic for loading/updating dashboard data. |
| **ExploreTheFarm** | Interactive farm map using MapKit, with buttons for exploring venues, food, activities. |
| **FarmToTable** | Farm-to-table experience overview, including sustainability practices and cooking class information. |
| **FoodDash** | Displays user's food-related bookings and quick links to meal options. |
| **FoodForm** | Form to enter meals for calorie tracking. |
| **FoodPreferences** | Collect and manage user dietary preferences for meal personalization. |
| **LargeGroupActivities** | Book activities for large groups (10+ people). |
| **LoginView** | User login page. |
| **MealRecommendation** | Submit wellness goals to receive AI meal recommendations (connected to AWS Lambda). |
| **PhotoGallery** | Displays farm photos and event images. |
| **PostCalorieData** | Sends calorie tracking data to AWS Lambda. |
| **PostFoodRequest** | Sends food preference data to AWS Lambda. |
| **PostMealRequest** | Sends meal recommendation data to AWS Lambda. |
| **PostRequest** | Sends activity recommendation data to AWS Lambda. |
| **Recommendations** | Displays personalized activity/wellness recommendations retrieved from AWS Lambda. Not currently using accurate information, holds dummy data.|
| **RentalSpace** | Book conference rooms, ballrooms, restaurant spaces for events. |
| **SignupView** | User signup page. |
| **SummersWellnessFarmApp** | Main entry point (`@main`) loading the ContentView. |
| **User** | SwiftData model for user information. |
| **UserPreferences** | SwiftData model for dietary and wellness preferences. |
| **UserSession** | Manages user authentication and session state. |
| **Watch** | Integrates smartwatch features (Apple, Garmin, Fitbit planned). |
| **WeddingDash** | Dashboard for wedding event groups. |

---
# ☁️ AWS Lambda Setup Instructions

Inside your project, there is a `BackendHandlers/` folder containing:

- `BaseLambda/` (contains shared libraries like `openai/`, and helper code)
- Separate lambda functions:
  - `CalorieTrackerLambda.py`
  - `FoodPreferencesLambda.py`
  - `MealRecommendationLambda.py`
  - `ActivityRecommendationLambda.py`
- `activity_names.txt`
- `meal_options_by_type.json`

Each `lambda_function.py` template must be merged with `BaseLambda/` to create a working Lambda and potentially a txt file or json file.

---

## 🔹 General AWS Setup for Each Lambda

### 1. Prepare Files Locally

- Start by downloading the `BaseLambda/` folder **inside** of `BackendHandlers/`.
- Select the correct `lambda_function.py` called one of `CalorieTrackerLambda.py`, `FoodPreferencesLambda.py`, `MealRecommendationLambda.py`, `ActivityRecommendationLambda.py`.  MAKE SURE YOU ARE RENAMING THE LAMBDA FUNCTION YOU ARE PLANNING ON USING TO -> `lambda_function.py` otherwise it will not work.
- **Add** the `lambda_function.py` **into the BaseLambda folder** (overwrite or add it).
- **If extra files are required, add them**:
  - `ActivityRecommendationLambda.py` ➔ add `activity_names.txt`
  - `MealRecommendationLambda.py` ➔ add `meal_options_by_type.json`
- **Rename the final merged folder** to match the Lambda's purpose:
  - Example: `CalorieTrackerLambda/`, `MealRecommendationLambda/`, etc.
- **Zip the folder** for upload:
  - The zip should contain `lambda_function.py`, `openai/`, and any extra files **at the top level**, not inside another folder.

---

### 2. Upload to AWS Lambda

- Go to [AWS Lambda](https://aws.amazon.com/lambda/).
- Sign into AWS and navigate to the console  
- Create a new function: **Author from scratch**.
- Architecture: **x86_64**
- Runtime: **Python 3.12**.
- Create the new function. 
- Upload the zipped folder (Code → Upload from → .zip file).

---

### 3. Add OpenAI API Key to Lambda
If you don't already have an OpenAI API key:

- Follow the instructions in the section below: [🔑 How to Create an OpenAI API Key](#-how-to-create-an-openai-api-key).

Once you have your API key:
- Go to **Configuration** → **Environment Variables** → **Edit**.
- Add a new environment variable:
  - **Key**: `OPENAI_API_KEY`
  - **Value**: (Paste your OpenAI secret key.)

---

### 4. Configure Lambda Settings

- Set Timeout: **at least 60 seconds**.
- (Recommended) Set Memory Size: **512MB** or higher for better performance.

---

### 5. Create API Gateway Endpoint

- Go to [AWS API Gateway](https://aws.amazon.com/api-gateway/).
- Create a new **HTTP API**.
- Connect the API to your Lambda function.
- Enable CORS:
  - Allow **POST** method.
  - Allow origin `*` during development.

---

### 6. Update Swift App

- Insert the API Gateway URL in the correct Swift networking file:
  - `PostCalorieData.swift`
  - `PostFoodRequest.swift`
  - `PostMealRequest.swift`
  - `PostRequest.swift`

Replace the `// TODO: Insert API URL here` comment with your actual endpoint URL.

---

# 🗂️ Lambda Naming Convention and Special Notes

| Lambda | Extra Files Required | Final Folder Name |
|:------|:----------------------|:------------------|
| Calorie Tracker | None | `CalorieTrackerLambda/` |
| Food Preferences | None | `FoodPreferencesLambda/` |
| Meal Recommendation | `meals_options_by_type.json` | `MealRecommendationLambda/` |
| Activity Recommendation | `activity_names.txt` | `ActivityRecommendationLambda/` |

---

# 📦 Folder Structure Before Zipping

```
BackendHandlers/
├── BaseLambda/
├── CalorieTrackerLambda.py → Copy file ➔ Merge with BaseLambda ➔ Rename ➔ Upload
├── FoodPreferencesLambda.py → Copy file ➔ Merge with BaseLambda ➔ Rename ➔ Upload
├── MealRecommendationLambda.py → Copy file ➔ Merge with BaseLambda ➔ Rename ➔ Upload
├── ActivityRecommendationLambda.py → Copy file ➔ Merge with BaseLambda ➔ Rename ➔ Upload
├── meals_options_by_type.json
├──activity_names.txt
```

# 🔑 How to Create an OpenAI API Key

Follow these steps to create an API key that you will use in your AWS Lambda functions:

1. Go to the OpenAI website: [https://platform.openai.com/signup](https://platform.openai.com/signup)
2. If you don't have an account, **sign up** for a free account.
3. If you already have an account, **log in** at [https://platform.openai.com/login](https://platform.openai.com/login).
4. Once logged in, go to [https://platform.openai.com/account/api-keys](https://platform.openai.com/account/api-keys).
5. Click the **\"Create new secret key\"** button.
6. Give the key a name (optional).
7. Click **\"Create Secret Key\"**.
8. **IMPORTANT**: Copy the API Key immediately.  
   - You won't be able to see it again later!
9. Store the key somewhere safe (like a password manager).
10. Later, when you set up your AWS Lambda function, you will add this key as an environment variable:
    - **Key**: `OPENAI_API_KEY`
    - **Value**: (your copied API Key)

---

## Important Notes:
- OpenAI accounts require **billing enabled** to use paid models like `gpt-4`.  
- You can use free trial credits initially if they are available.
- Monitor your usage through [https://platform.openai.com/account/usage](https://platform.openai.com/account/usage).
- If you run out of credits, API calls will fail with an error.

---

# ⚠️ Error Handling in Lambda Functions

The Lambda functions are designed to catch common errors gracefully and output helpful debug information. Here's how errors are handled across the various handlers:

| Error Type | Where It Happens | Description | Handling |
|:-----------|:-----------------|:------------|:---------|
| Missing OpenAI API Key | `get_api_key()` | Checks if the `OPENAI_API_KEY` environment variable is missing. | Logs `[DEBUG] API Key not found` and raises a `ValueError`. |
| Missing activity_names.txt | `load_activity_names()` (Activity Lambda) | Attempts to load activities from a text file. | Logs an error and returns an empty list if missing or unreadable. |
| Invalid OpenAI API Response | After `openai.ChatCompletion.create()` | Ensures that `choices[0]["message"]["content"]` exists in the response. | Raises a `ValueError` if missing or malformed. |
| Prompt Generation Failure | `generate_prompt()` functions | Catches exceptions during prompt creation from user data. | Logs `[ERROR] Failed to generate prompt` and falls back to a basic prompt. |
| Exception During Lambda Handler | Entire `lambda_handler()` | Wraps the whole flow inside a try-except block. | Logs the exception details and returns a `500` status with the error message. |
| Invalid JSON in Request Body | Parsing `event["body"]` | If body is not JSON-parsable. | Logs parsing failure, throws an exception, returns `500`. |
| OpenAI API Timeout/Error | During API call to `openai.ChatCompletion.create()` | Handles API server errors, timeouts, or rate limits. | Exception logged, and `500` status returned to the client. |

---

## Notes:
- **CloudWatch** is used for logging all `[DEBUG]`, `[ERROR]`, and `[INFO]` output.
- Each function prints the raw event received to help with debugging input issues.
- Defensive programming is used around all OpenAI API responses to avoid app crashes.
- Timeout for Lambda should be increased to **60 seconds** to accommodate OpenAI response times.

---

# 🛠️ Common AWS Setup Errors and Fixes

| Issue | Cause | How to Fix |
|:------|:------|:-----------|
| `Missing API Key` error from Lambda | Forgot to add environment variable `OPENAI_API_KEY` | Go to Lambda → Configuration → Environment Variables → Add the key and value. |
| `Internal Server Error (500)` on API call | Lambda code crashed | Check CloudWatch logs → look for syntax errors or missing environment variables. |
| API Gateway returns CORS error in Swift app | CORS is not enabled properly | Edit your API Gateway settings → Enable CORS and allow POST methods. |
| Lambda timeout error | OpenAI API took too long | Increase Lambda timeout setting to at least 60 seconds. |
| `activity_names.txt` or `meals.json` not found | Forgot to include extra file in zipped package | Double-check zip includes `activity_names.txt` or `meals.json` at the top level. |
| Upload error: \"zip file too large\" | Package is too big or improperly zipped | Only zip the contents (openai/, lambda_function.py, etc.), not the folder itself. |

# 🗺️ System Flow Overview

<img width="650" alt="Screenshot 2025-04-27 at 4 20 11 PM" src="https://github.com/user-attachments/assets/999e693b-9843-4212-93ae-4a329e23f90c" />

# 💵 Billing Reminders

- AWS Lambda: The free tier includes **1 million requests** and **400,000 GB-seconds** of compute time per month for 12 months.
- AWS API Gateway: Free tier includes **1 million HTTP API calls** per month for 12 months.
- OpenAI: Free trial credits ($5) expire after 3 months. You must set up billing if you want uninterrupted service.
- Always monitor AWS billing dashboard [AWS Billing Console](https://console.aws.amazon.com/billing/home).
- Always monitor OpenAI usage here: [OpenAI Usage Dashboard](https://platform.openai.com/account/usage).

---
# ✅ Deployment Final Checklist

Before deploying your Lambda, make sure:
- [ ] You have copied `lambda_function.py` into `BaseLambda/`.
- [ ] You have added `activity_names.txt` or `meals_options_by_type.json` if needed.
- [ ] You renamed the merged folder properly (e.g., `CalorieTrackerLambda/`).
- [ ] You zipped only the contents (no nested folders).
- [ ] You created the function using Python 3.12 and x86_64 architecture.
- [ ] You uploaded the zip to Lambda.
- [ ] You added `OPENAI_API_KEY` in environment variables.
- [ ] You increased the timeout to at least 60 seconds.
- [ ] You created an HTTP API Gateway and enabled CORS.
- [ ] You updated the API URL in your Swift app.
- [ ] You tested using CloudWatch logs if something fails.

