//
//  AddToShopView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/12/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct AddToShopView: View {
    @EnvironmentObject var customer: Customer
    @EnvironmentObject var admin: Administrator
    @State private var price = 0.0
    @State private var name = ""
    @State private var category = "Default"
    @State private var description = ""
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var uiImage: UIImage?
    @State private var showingImagePicker = false
    
    @Binding var screen: Int
    @ObservedObject var decoding = HttpAuth()
    @EnvironmentObject var items: ItemsList
    
    @State private var alertShowing = false

    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    Color.gray
                        .frame(width: 300, height: 200)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                    }
                    else {
                        Text("Click here to add a photo")
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                Form {
                    Section(header: Text("Enter a name")) {
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("Enter a description")) {
                        TextField("Name", text: $description)
                    }
                    Section(header: Text("Enter a price")) {
                        Slider(value: $price, in: 0 ... 200)
                    }
                    
                    Text("Price: $\(price, specifier: "%.2f")")
                    
                }
                
                Button("Add") {
                    //print(self.admin.token)
                    let newPrice = Double(String(format: "%.2f", self.price))!
                    if self.uiImage != nil {
                        self.decoding.addItem(token: self.admin.token, price: Float(newPrice), description: self.description, picture: self.uiImage!, category: self.category, name: self.name, link: "https://hkp-shop.herokuapp.com/vendor/items/create") {result in
                            switch result {
                                case .success(let str):
                                    print(str)
                                    self.loadItems()
                                    self.screen = 5
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
                        self.loadItems()
                        self.screen = 5
                    } else {
                        self.alertShowing = true
                    }
                    
                }
                .padding(.bottom)
            }
            .navigationBarTitle("Add Item to Shop")
            .navigationBarItems(trailing: Button("Cancel") {
                self.screen = 5
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: addImage) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $alertShowing) {
                Alert(title: Text("Error"), message: Text("No picture selected"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addImage() {
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
        uiImage = inputImage
        
    }
    
    func loadItems() {
        print("function called")
        self.decoding.getItemList(token: admin.token, link: "https://hkp-shop.herokuapp.com/vendor/items") {result in
        switch result {
            case .success(let str):
                DispatchQueue.main.async {
                    //self.items = ItemsList(items: str)
                    self.items.replace(str)
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

//struct AddToShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToShopView()
//    }
//}
