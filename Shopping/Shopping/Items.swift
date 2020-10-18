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
    
}
