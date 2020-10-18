//
//  Cart.swift
//  Shopping
//
//  Created by Kayla Fang on 10/18/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation


class Cart: ObservableObject {
    @Published var items: [StoreItem] = [StoreItem]() {
        willSet {
            objectWillChange.send()
        }
    }
}
