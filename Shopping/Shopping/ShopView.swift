//
//  ShopView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct ShopView: View {
    @Binding var screen: Int
    
    var body: some View {
        VStack {
            Text("Welcome to Shop.com!")
            
            Button("Add a new item") {
                self.screen = 3
            }
        }
    }
}

//struct ShopVieSecureFieldw_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopView()
//    }
//}
