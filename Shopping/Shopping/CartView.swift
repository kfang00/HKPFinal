//
//  CartView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/16/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Items")
            }
            .navigationBarTitle("Cart")
            .navigationBarItems(trailing:
                Button("Back to Shop") {
                //switch to shop view
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
