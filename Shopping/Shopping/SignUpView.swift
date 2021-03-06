//
//  SignUpView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    //@ObservedObject var customerList: Customers
    //@ObservedObject var administratorList: Administrators
    @State private var username = ""
    @State private var password = ""
    @Binding var screen: Int
    @State private var showingError = false
    @State private var alertMessage = ""
    
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
                SecureField("Password", text: $password)
                    .padding(.leading)
                
                Text("Sign Up as")
                    .padding()
                
                HStack {
                    Button("Customer") {
                        //let customer = Customer(username: self.username, password: self.password)
                        //self.customerList.customers.append(customer)
                        self.encoding.signUp(username: self.username, password: self.password, link: "https://hkp-shop.herokuapp.com/signup") {result in
                        switch result {
                            case .success(let str):
                                DispatchQueue.main.async {
                                    if str.success != nil {
                                        self.screen = 0
                                    }
                                    if str.error != nil {
                                        self.showingError = true
                                        self.alertMessage = str.error ?? ""
                                    }
                                }
                            case .failure(let error):
                                switch error {
                                case .badURL:
                                    print("Bad URL")
                                case .requestFailed:
                                    print("Network problems")
                                case .unknown:
                                    print("Unknown error")
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    
                    Button("Administrator") {
                        //let administrator = Administrator(username: self.username, password: self.password)
                        //self.administratorList.administrators.append(administrator)
                        self.encoding.signUp(username: self.username, password: self.password, link: "https://hkp-shop.herokuapp.com/signup/admin") {result in
                        switch result {
                            case .success(let str):
                                DispatchQueue.main.async {
                                    if str.success != nil {
                                        self.screen = 0
                                    }
                                    if str.error != nil {
                                        self.showingError = true
                                        self.alertMessage = str.error ?? ""
                                    }
                                }
                            case .failure(let error):
                                switch error {
                                case .badURL:
                                    print("Bad URL")
                                case .requestFailed:
                                    print("Network problems")
                                case .unknown:
                                    print("Unknown error")
                                }
                            }
                            
                        }
                        
                        //self.screen = 0
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                }
                
                
                Spacer()
            }
        .navigationBarTitle("Shopping")
        .navigationBarItems(trailing: Button("Login") {
            self.screen = 0
        })
        .alert(isPresented: $showingError) {
                Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
        }
    }
    

}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
