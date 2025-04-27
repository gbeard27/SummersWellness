//
//  PostCalorieData.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/26/25.
//

import Foundation

struct CalorieTrackingRequest: Codable {
    let age: Int
    let gender: String
    let height: Double
    let weight: Double
    let activities: [ActivityData]
    let meals: [String: String]
    let steps: Double?
    let calories: Double?
    let hoursOfSleep: Double?
}

struct ActivityData: Codable {
    let name: String
    let duration: Int
    let intensity: String
}

func sendCalorieData(
    age: Int,
    gender: String,
    height: Double,
    weight: Double,
    selectedActivities: Set<String>,
    activityDurations: [String: Int],
    activityIntensity: [String: String],
    steps: Double?,
    calories: Double?,
    hoursOfSleep: Double?,
    breakfast: String,
    lunch: String,
    dinner: String,
    snack: String,
    completion: @escaping (Result<String, Error>) -> Void
) {
    let activities: [ActivityData] = selectedActivities.map { activity in
        ActivityData(
            name: activity,
            duration: activityDurations[activity, default: 30],
            intensity: activityIntensity[activity, default: "Moderate"]
        )
    }

    let mealData = [
        "Breakfast": breakfast,
        "Lunch": lunch,
        "Dinner": dinner,
        "Snack": snack
    ].filter { !$0.value.trimmingCharacters(in: .whitespaces).isEmpty }

    let requestBody = CalorieTrackingRequest(
        age: age,
        gender: gender,
        height: height,
        weight: weight,
        activities: activities,
        meals: mealData,
        steps: steps,
        calories: calories,        
        hoursOfSleep: hoursOfSleep
    )

    guard let url = URL(string: "// TODO: Insert API Gateway Endpoint URL here") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let encodedData = try JSONEncoder().encode(requestBody)
        request.httpBody = encodedData
        
        // Print the JSON payload to the console
        if let jsonString = String(data: encodedData, encoding: .utf8) {
            print("DEBUG: Sending payload: \(jsonString)")
        }
    } catch {
        completion(.failure(error))
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        if let data = data {
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let recommendation = json["recommendation"] as? String {
                    completion(.success(recommendation))
                } else {
                    completion(.failure(NSError(domain: "Missing 'recommendation' key", code: 0)))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }.resume()
}
