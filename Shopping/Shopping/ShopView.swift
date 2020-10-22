//
//  ShopView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    @Binding var screen: Int
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var itemsStore: StoreList
    var index: Int
    @State private var showDetailView = false
    
     var body: some View {
        VStack (spacing: 5){
            if index != self.itemsStore.items.count {
                NavigationLink(destination: DetailView(item: itemsStore.items[index]), isActive: $showDetailView) {
                    EmptyView()
                }
                Image(uiImage: UIImage(data: Data(base64Encoded: self.itemsStore.items[index].picture.data)!)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 105)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2))
                    .shadow(radius: 5)
                    .onTapGesture {
                        self.showDetailView = true
                    }
                    //.padding(.horizontal)
                
                Text(self.itemsStore.items[index].name)
                    .font(.headline)
                //Text("Description: \(self.itemsStore.items[index].description)")
                Text("Seller: \(self.itemsStore.items[index].seller.username)")
                    .font(.subheadline)
                Button("Add To Cart") {
                                 
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .onTapGesture {
                    self.cart.add(item: self.itemsStore.items[self.index])
                    self.screen = 4
                }

                Spacer()
                Text("$\(self.itemsStore.items[index].price, specifier: "%.2f")")
            }
        }
        .padding(.bottom)
    }

}

struct ShopView: View {
    @Binding var screen: Int
    @EnvironmentObject var itemsStore: StoreList
    @ObservedObject var decoding = HttpAuth()
    
    
    var body: some View {
        GeometryReader {geo in
            NavigationView{
                VStack{
                    Text("Welcome to Shop.com!")
                        .font(.title)
                    List{
                        ForEach(Array(stride(from: 0, to: self.itemsStore.items.count, by: 2)), id:\.self) { index in
                            HStack {
                                //Spacer()
                                ItemView(screen: self.$screen, index: index)
                                    .padding(.horizontal, 1)
                                    .frame(width: geo.size.width / 2.3)
                                //Spacer()
                                ItemView(screen: self.$screen, index: index + 1)
                                    .padding(.horizontal, 1)
                                    .frame(width: geo.size.width / 2)
                                //Spacer()
                            }
                                
                            
                        }
                    }
                }
                .navigationBarTitle("Shop")
                .navigationBarItems(leading: Button("Logout") {
                self.screen = 0
                } , trailing: Button ("Cart") {
                    self.screen = 4
                })
            }
        }
        .onAppear(perform: loadItems)
    }
    
//    func groupInto2() {
//        var newItemList: [[StoreItem]] = []
//        var i = 0
//        while i < itemsStore.items.count - 1{
//            var pair = itemsStore.items[i ..< (i + 2)]
//            newItemList.append(pair)
//        }
//    }
    
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
