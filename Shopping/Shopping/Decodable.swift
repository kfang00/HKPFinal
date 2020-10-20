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

struct StoreMessage: Decodable {
    var success: Store
}

struct Store:Decodable {
    var items: [StoreItem]
}

struct StoreItem: Decodable , Identifiable {
    let id = UUID()
    var category: String
    var description: String
    var name: String
    var picture: Picture
    var price: Float
    var seller: Seller
}

struct Seller: Decodable {
    var username: String
}

struct AddMessage: Decodable {
    var success: Items?
    //var error : String?
    
    init(success: Items) {
        self.success = success
        //self.error = error
    }
}

struct Items: Decodable {
    var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}

struct Item: Decodable, Identifiable {
    let id = UUID()
    var category: String
    var description: String
    var name: String
    var picture: Picture
    var price: Float
    var token: String?
    
    
    init(token: String, price: Float, description: String, picture: Picture, category: String, name: String) {
        self.token = token
        self.price = price
        self.description = description
        self.picture = picture
        self.category = category
        self.name = name
        
    }
    
}

struct Picture: Decodable {
    var data: String

}

struct Message: Decodable {
    var success: Success?
    var error : String?
    
    init(success: Success, error: String) {
        self.success = success
        self.error = error
    }
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
    
    
    func login(username: String, password: String, link: String, completion:  @escaping (Result<Message, NetworkError>) -> Void) {
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
                    completion(.success(finalData))
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
    
    func addItem(token: String, price: Float, description: String, picture: UIImage, category: String, name: String, link: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
        let jpegData = picture.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        //print(jpegData)
        let parameters = ["category": category, "description": description, "name": name, "picture": jpegData, "price": price, "token": token] as [String : Any]
        
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
    
    func getItemList(token: String, link: String, completion:  @escaping (Result<[Item], NetworkError>) -> Void) {
        //let parameters = ["token": token]
        
        var components = URLComponents(string: link)!
        components.queryItems = [URLQueryItem(name: "token", value: token)]
            
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                //print(data)
                if let finalData = try? JSONDecoder().decode(AddMessage.self, from: data) {
                   //print(finalData)
                   completion(.success(finalData.success!.items))
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
    
    func getStoreList(link: String, completion:  @escaping (Result<[StoreItem], NetworkError>) -> Void) {
        guard let url = URL(string: link) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                //print(data)
                //try! JSONDecoder().decode(Store.self, from: data)
                if let finalData = try? JSONDecoder().decode(StoreMessage.self, from: data) {
                   //print(finalData)
                    completion(.success(finalData.success.items))
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
