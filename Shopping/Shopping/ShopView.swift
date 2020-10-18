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
    @EnvironmentObject var items: ItemsList
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to Shop.com!")
                    .font(.title)
                
                Spacer()
            }
            .navigationBarTitle("Shop")
            .navigationBarItems(trailing: Button ("Cart") {
                self.screen = 4
            })
        }
    }
}

//struct ShopVieSecureFieldw_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopView()
//    }
//}
