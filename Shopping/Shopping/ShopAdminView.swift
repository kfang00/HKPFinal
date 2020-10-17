//
//  ShopAdminView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/17/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct ShopAdminView: View {
    @Binding var screen: Int
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to Shop.com!")
                    .font(.title)
                
                Button("Add a new item") {
                    self.screen = 3
                }
                Spacer()
            }
            .navigationBarTitle("Shop")
        }
    }
}

//struct ShopAdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopAdminView()
//    }
//}
