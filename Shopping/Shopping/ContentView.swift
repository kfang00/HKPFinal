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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
