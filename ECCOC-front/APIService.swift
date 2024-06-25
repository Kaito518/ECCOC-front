//
//  APIService.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/21.
//

import Foundation

struct User: Codable {
    let id: Int?
    let username: String
    let email: String
    let password: String?
}

class APIService {
    let baseURL = "http://localhost:3000/users"

    func register(username: String, email: String, password: String, completion: @escaping (User?) -> Void) {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let user = User(id: nil, username: username, email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(user)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let user = try? JSONDecoder().decode(User.self, from: data)
            completion(user)
        }.resume()
    }

    func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginData = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(loginData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let user = try? JSONDecoder().decode(User.self, from: data)
            completion(user)
        }.resume()
    }
}
