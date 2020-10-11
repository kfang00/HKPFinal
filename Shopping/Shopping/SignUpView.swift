//
//  SignUpView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var customerList: Customers
    @ObservedObject var administratorList: Administrators
    @State private var username = ""
    @State private var password = ""
    @Binding var screen: Int
    
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
                        //self.saveData()
                        self.screen = 0
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    
                    Button("Administrator") {
                        let administrator = Administrator(username: self.username, password: self.password)
                        self.administratorList.administrators.append(administrator)
                        //self.saveData()
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
    
//    func saveData() {
//        let parameters = [username: customerList]
//        guard let encoded = try? JSONEncoder().encode(customerList) else {
//            print("Fail to encode customers")
//            return
//        }
//        guard let encoded2 = try? JSONEncoder().encode(administratorList) else {
//            print("Fail to encode administrators")
//            return
//        }
//        guard let url = URL(string: "https://hkp-shop.herokuapp.com/login") else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.httpBody = encoded
//        var request2 = URLRequest(url: url)
//        request2.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request2.httpMethod = "POST"
//        request2.httpBody = encoded2
//
//        URLSession.shared.dataTask(with: request) {data, response, error in
//            if let response = response {
//                print(response)
//                return
//            }
//            print("Error")
//            return
//
//        }.resume()
//
//    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
