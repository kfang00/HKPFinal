//
//  User.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation

class Customer: ObservableObject {
    @Published var token: String = "default" {
        willSet {
            objectWillChange.send()
        }
    }

}

