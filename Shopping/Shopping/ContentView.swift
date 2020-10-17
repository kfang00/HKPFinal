//
//  ContentView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var customer = Customer()
    @ObservedObject var admin = Administrator()
    //@ObservedObject var customerList = Customers()
    //@ObservedObject var administratorList = Administrators()
    //@State private var chosenUser = Customer?.self
    
    @State private var isUser = false
    
    @State private var screen = 0
    
    var body: some View {
        Group {
            if screen == 0 {
                LoginView(screen: $screen)
            }
            if screen == 1{
                SignUpView(screen: $screen)
            }
            if screen == 2{
                ShopView(screen: $screen)
            }
            if screen == 3{
                AddToShopView(screen: $screen)
            }
            if screen == 4{
                CartView(screen: $screen)
            }
            if screen == 5{
                ShopAdminView(screen: $screen)
            }
        }
        .environmentObject(admin)
        .environmentObject(customer)
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
