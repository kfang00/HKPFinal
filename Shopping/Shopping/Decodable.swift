//
//  Decodable.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Message: Decodable {
    var success: Success?
    var error : String?
    
    init(success: Success, error: String) {
        self.success = success
        self.error = error
    }
}

struct AddMessage: Decodable {
    var success: Item?
    var error : String?
    
    init(success: Item, error: String) {
        self.success = success
        self.error = error
    }
}

struct Item: Decodable {
    var token: String
    var price: Float
    var description: String
    var picture: String
    var category: String
    
}

struct Success: Decodable {
    var token: String

}

class HttpAuth: ObservableObject  {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    enum NetworkError: Error {
        case badURL, requestFailed, unknown
    }
    
    func signUp(username: String, password: String, link: String) {
        let parameters = ["username": username, "password": password]
        
        guard let url = URL(string: link) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                
                guard let finalData = try? JSONDecoder().decode(Message.self, from: data) else {
                    return
                }
                    print(finalData)
            }
            print("Error")
            return

        }.resume()

    }
    
    
    func login(username: String, password: String, link: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
        let parameters = ["username": username, "password": password]
        
        guard let url = URL(string: link) else {
            completion(.failure(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //var success = false
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                if let finalData = try? JSONDecoder().decode(Message.self, from: data) {
                    print(finalData)
                    if finalData.success != nil {
                        //success = true
                        completion(.success(finalData.success!.token))
                    }
                }
            }
            else if error != nil {
                completion(.failure(.requestFailed))
            }
            //print(success)
            return

        }
        task.resume()
        return
    }
    
    func addItem(token: String, price: Float, description: String, picture: UIImage, category: String, link: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
        let jpegData = picture.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        
       let parameters = ["token": token, "price": price, "description": description, "picture": jpegData, "category": category] as [String : Any]
        
        guard let url = URL(string: link) else {
            completion(.failure(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                //print("done")
                if let finalData = try? JSONDecoder().decode(AddMessage.self, from: data) {
                    print(finalData)
//                    if finalData.success != nil {
//                        completion(.success("success"))
//                    }
                } else {
                    print("error occurred")
                }
            }
            else if error != nil {
                completion(.failure(.requestFailed))
            }
            return

        }
        task.resume()
        return
    }
    
}
