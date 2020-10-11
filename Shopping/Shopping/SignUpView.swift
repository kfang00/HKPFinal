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
                        self.screen = 0
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    
                    Button("Administrator") {
                        let administrator = Administrator(username: self.username, password: self.password)
                        self.administratorList.administrators.append(administrator)
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