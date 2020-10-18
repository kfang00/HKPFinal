//
//  CartView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/16/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @Binding var screen: Int
    @EnvironmentObject var cart: StoreList
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Items")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .navigationBarTitle("Cart")
            .navigationBarItems(trailing:
                Button("Back to Shop") {
                    self.screen = 2
            })
        }
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
