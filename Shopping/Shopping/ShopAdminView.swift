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
                List{
                    ForEach(0 ..< items.items.count, id:\.self) { index in
                        HStack{
                            Image(uiImage: UIImage(data: Data(base64Encoded: self.items.items[index].picture.data)!)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 105)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2))
                                .shadow(radius: 5)
                                //.padding(.horizontal)
                            VStack (alignment: .leading){
                                Text(self.items.items[index].name)
                                    .font(.headline)
                                Text(self.items.items[index].description)
                            }
                                .padding(.horizontal)
                            Spacer()
                            Text("$\(self.items.items[index].price, specifier: "%.2f")")
                            Button(action: {self.removeItem(id: self.items.items[index].id, index: index)}){
                                Image(systemName: "trash")
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        
                    }
                    //.onDelete(perform: removeItem)
                }
                
                Spacer()
            }
            .navigationBarTitle("Your Items")
            .navigationBarItems(leading: Button("Logout") {
                self.screen = 0
            } , trailing: Button("Add a new item") {
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
    
//    func removeItem(at offsets: IndexSet) {
//        items.items.remove(atOffsets: offsets)
//        //let deleted = items.items[offsets.startIndex]
//    }
    
    func removeItem(id: String, index: Int) {
        items.items.remove(at: index)
        self.decoding.deleteItem(token: admin.token, id: id, link: "https://hkp-shop.herokuapp.com/vendor/items/delete")
    }
}

//struct ShopAdminView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShopAdminView()
//    }
//}
