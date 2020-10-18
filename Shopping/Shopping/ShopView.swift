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
    @EnvironmentObject var itemsStore: StoreList
    @ObservedObject var decoding = HttpAuth()
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to Shop.com!")
                    .font(.title)
                
                List(itemsStore.items) { item in
                    VStack(spacing: 5){
                        Image(uiImage: UIImage(data: Data(base64Encoded: item.picture.data)!)!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 105)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2))
                            .shadow(radius: 5)
                            //.padding(.horizontal)
                        Text(item.name)
                            .font(.headline)
                        Text("Description: \(item.description)")
                        Text("Seller: \(item.seller.username)")
                            .font(.subheadline)
                        Button("Add To Cart") {
                        
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())

                        Spacer()
                        Text("$\(item.price, specifier: "%.2f")")
                        
                    }
                    
                }
            }
            .navigationBarTitle("Shop")
            .navigationBarItems(trailing: Button ("Cart") {
                self.screen = 4
            })
        }
        .onAppear(perform: loadItems)
    }
    
    func loadItems() {
        self.decoding.getStoreList(link: "https://hkp-shop.herokuapp.com/store") {result in
        switch result {
            case .success(let str):
                DispatchQueue.main.async {
                    //self.items = ItemsList(items: str)
                    self.itemsStore.items = str
                }
                //print(str)
            case .failure(let error):
                switch error {
                case .badURL:
                    print("Bad URL")
                case .requestFailed:
                    print("Network problems")
                case .unknown:
                    print("Unknown error")
                }
            }
        }
    }
    
}

//struct ShopVieSecureFieldw_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopView()
//    }
//}
