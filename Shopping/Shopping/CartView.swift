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
    @EnvironmentObject var cart: Cart
    @State private var total = Float(0.0)
    
    var body: some View {
        NavigationView {
            VStack (spacing: 5){
                Text("Your Items")
                    .font(.title)
                    .bold()
                Text("Swipe to delete")
                    .font(.subheadline)
                if cart.items.count == 0 {
                    Text("Your Cart Is Empty")
                        .padding()
                        .foregroundColor(.secondary)
                }
                List{
                    ForEach(cart.items) { item in
                        HStack{
                            Image(uiImage: UIImage(data: Data(base64Encoded: item.picture.data)!)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 105)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2))
                                .shadow(radius: 5)
                                //.padding(.horizontal)
                            VStack (alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                            }
                                .padding(.horizontal)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                            
                        }
                    }
                    .onDelete(perform: removeItem)
                    
                }
                Spacer()
                Text("Total: $\(calculateTotal(), specifier: "%.2f")")
                Button("Checkout") {
                    
                }
            }
            .navigationBarTitle("Cart")
            .navigationBarItems(trailing:
                Button("Back to Shop") {
                    self.screen = 2
            })
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        cart.items.remove(atOffsets: offsets)
    }
    
    func calculateTotal() -> Float{
        var total = Float(0.0)
        for i in cart.items {
            total += i.price
        }
        return total
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
