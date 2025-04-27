//  PostRequest.swift
//  SummersWellnessFarm
//
//  Created by Grace Beard on 3/24/25.
//
import Foundation

func fetchAIRecommendation(preferences: [String], completion: @escaping (String?) -> Void) {
    //API Gateway URL
    guard let url = URL(string: "// TODO: Insert API Gateway Endpoint URL here") else {
        completion("Invalid URL")
        return
    }

    //Generates dictory to send as JSON
    let body: [String: Any] = ["preferences": preferences]

    //Sending JSON with the http POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    } catch {
        completion("Failed to encode preferences")
        return
    }

    //Initiates HTTP request
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
    }.resume() //starts the network request


}
