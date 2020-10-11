//  LoginView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var customerList: Customers
    @ObservedObject var administratorList: Administrators
    @State private var username = ""
    @State private var password = ""
    @Binding var screen: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Enter in your username")
                    .font(.headline)
                TextField("Username", text: $username)
                    .padding()
                
                Text("Enter in your password")
                    .font(.headline)
                TextField("Password", text: $password)
                    .padding(.leading)
                
                Text("Sign in as")
                    .padding()
                HStack {
                    Button("Customer") {
                        if self.isLoginSuccessfulCustomer() {
                            self.screen = 2
                        }
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    
                    Button("Administrator") {
                        if self.isLoginSuccessfulAdministrator() {
                            self.screen = 2
                        }
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                }
                
                Spacer()
            }
        .navigationBarTitle("Shopping")
            .navigationBarItems(trailing: Button("Sign Up") {
                self.screen = 1
            })
        .padding()
        }
    }
    
    func isLoginSuccessfulCustomer() -> Bool {
        if let match = self.customerList.customers.firstIndex(where: {$0.username == self.username}) {
            if self.customerList.customers[match].password == self.password {
                return true
            }
        }
        return false
    }
    
    func isLoginSuccessfulAdministrator() -> Bool {
        if let match = self.administratorList.administrators.firstIndex(where: {$0.username == self.username}) {
            if self.administratorList.administrators[match].password == self.password {
                return true
            }
        }
        return false
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(screen: )
//    }
//}
