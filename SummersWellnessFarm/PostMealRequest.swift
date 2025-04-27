//
//  PostMealRequest.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 4/9/25.
//

import Foundation

func fetchMealAIRecommendation(preferences: [String], dietaryInfo: GuestPreferences?, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "// TODO: Insert API Gateway Endpoint URL here") else {
        completion("Invalid URL")
        return
    }

    var body: [String: Any] = ["preferences": preferences]

    if let guest = dietaryInfo {
        body["dietary"] = [
            "name": guest.name,
            "allergies": guest.allergies,
            "diets": guest.diets,
            "specialRequests": guest.specialRequests
        ]
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    } catch {
        completion("Failed to encode preferences")
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion("No response from server")
            return
        }

        print("Raw API response body:", String(data: data, encoding: .utf8) ?? "nil")

        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let recommendation = result["recommendation"] as? String {
                completion(recommendation)
            } else {
                completion("Failed to parse AI response")
            }
        } catch {
            completion("JSON error: \(error.localizedDescription)")
        }
    }.resume()
}
