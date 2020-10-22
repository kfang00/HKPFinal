//
//  DetailView.swift
//  Shopping
//
//  Created by Kayla Fang on 10/22/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var item: StoreItem
    
    var body: some View {
        GeometryReader { geo in
            NavigationView{
                VStack {
                    Image(uiImage: UIImage(data: Data(base64Encoded: self.item.picture.data)!)!)
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width, height: 300)
                    
                    Text(self.item.name)
                        .font(.title)
                        .bold()
                        .padding()
                    Text("Description: ")
                        .bold()
                    + Text("\(self.item.description)")
                    Text("Seller: ")
                        .bold()
                    + Text("\(self.item.seller.username)")
                    Text("$\(self.item.price, specifier: "%.2f")")
                        .padding()
                    Spacer()
                }
            }
            .navigationBarTitle("\(self.item.name)", displayMode: .inline)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
