//
//  SignUpView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

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
    
    func saveData(username: String, password: String) {
        let parameters = ["username": username, "password": password]
        
        guard let url = URL(string: "https://hkp-shop.herokuapp.com/signup") else {
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
                //self.response = finalData
                    print(finalData)
            }
            print("Error")
            return

        }.resume()

    }
    
    func loadData(username: String, password: String, completion:  @escaping (Result<String, NetworkError>) -> Void) {
       completion(.failure(.badURL))
        let parameters = ["username": username, "password": password]
        
        guard let url = URL(string: "https://hkp-shop.herokuapp.com/login") else {
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
        
        var success = false
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                
                if let finalData = try? JSONDecoder().decode(Message.self, from: data) {
                    print(finalData)
                    if finalData.success != nil {
                        success = true
                        completion(.success("success"))
                    }
                    
                }
                    
            }
            else if error != nil {
                completion(.failure(.requestFailed))
            }
            print(success)
            return

        }
        task.resume()
        
        return
    }
}

struct SignUpView: View {
    @ObservedObject var customerList: Customers
    @ObservedObject var administratorList: Administrators
    @State private var username = ""
    @State private var password = ""
    @Binding var screen: Int
    
    @ObservedObject var encoding = HttpAuth()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Choose your username")
                    .font(.headline)
                TextField("Username", text: $username)
                    .padding()
                
                Text("Choose your password")
                    .font(.headline)
                TextField("Password", text: $password)
                    .padding(.leading)
                
                Text("Sign Up as")
                    .padding()
                HStack {
                    Button("Customer") {
                        let customer = Customer(username: self.username, password: self.password)
                        self.customerList.customers.append(customer)
                        self.encoding.saveData(username: self.username, password: self.password)
                        self.screen = 0
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    
                    Button("Administrator") {
                        let administrator = Administrator(username: self.username, password: self.password)
                        self.administratorList.administrators.append(administrator)
                        self.encoding.saveData(username: self.username, password: self.password)
                        self.screen = 0
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                }
                
                
                Spacer()
            }
        .navigationBarTitle("Shopping")
        .padding()
        }
    }
    

}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
