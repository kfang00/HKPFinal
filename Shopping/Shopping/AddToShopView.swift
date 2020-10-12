//
//  AddToShopView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/12/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct AddToShopView: View {
    @State private var price = 0.0
    @State private var name = ""

    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    Color.gray
                        .frame(width: 300, height: 200)
                    Text("Click here to add a photo")
                        .foregroundColor(Color.white)
                }
                .padding()
                
                Form {
                    Section(header: Text("Enter a price")) {
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("Enter a price")) {
                        Slider(value: $price, in: 0 ... 200)
                    }
                    
                    Text("Price: $\(price, specifier: "%.2f")")
                    
                    
                }
                
                Button("Add") {
                    
                }
                .padding(.bottom)
            }
            .navigationBarTitle("Add Item to Shop")
        }
    }
}

struct AddToShopView_Previews: PreviewProvider {
    static var previews: some View {
        AddToShopView()
    }
}
