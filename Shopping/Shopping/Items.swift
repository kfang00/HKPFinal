//
//  Items.swift
//  Shopping
//
//  Created by Kayla Fang on 10/17/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation

class ItemsList: ObservableObject {
    @Published var items: [Item] = [Item]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    func replace(_ items: [Item]) {
        objectWillChange.send()
        self.items = items

    }
}

class StoreList: ObservableObject {
    @Published var items: [StoreItem] = [StoreItem]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    func replace(_ items: [StoreItem]) {
        objectWillChange.send()
        self.items = items

    }
}
