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
    @EnvironmentObject var items: ItemsList
    @EnvironmentObject var admin: Administrator
    @ObservedObject var decoding = HttpAuth()
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to Shop.com!")
                    .font(.title)
                
                List(items.items) { item in
                    HStack{
                        Image(uiImage: UIImage(data: Data(base64Encoded: item.picture.data)!)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                        VStack (alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                        }
                    }
                    
                }
                
                Spacer()
            }
            .navigationBarTitle("Shop")
            .navigationBarItems(trailing: Button("Add a new item") {
                self.screen = 3
            })
        }
        .onAppear(perform: loadItems)
    }
    
    func loadItems() {
        self.decoding.getItemList(token: admin.token, link: "https://hkp-shop.herokuapp.com/vendor/items") {result in
        switch result {
            case .success(let str):
                DispatchQueue.main.async {
                    //self.items = ItemsList(items: str)
                    self.items.items = str
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

//struct ShopAdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopAdminView()
//    }
//}
