//
//  ContentView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var customerList = Customers()
    @ObservedObject var administratorList = Administrators()
    @State private var chosenUser = Customer?.self
    
    @State private var screen = 0
    
    var body: some View {
        Group {
            if screen == 0 {
                LoginView(customerList: customerList, administratorList: administratorList, screen: $screen)
            }
            if screen == 1{
                SignUpView(customerList: customerList, administratorList: administratorList, screen: $screen)
            }
            if screen == 2{
                ShopView()
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://hkp-shop.herokuapp.com/login") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedCustomers = try? JSONDecoder().decode(Customers.self, from: data) {
                    DispatchQueue.main.async {
                        self.customerList.customers = decodedCustomers.customers
                        print(self.customerList.customers[0].username)
                    }
                }
                if let decodedAdministrators = try? JSONDecoder().decode(Administrators.self, from: data) {
                    DispatchQueue.main.async {
                        self.administratorList.administrators = decodedAdministrators.administrators
                    }
                }
                return
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

            
        }.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
