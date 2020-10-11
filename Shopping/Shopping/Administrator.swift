//
//  Administrator.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation

class Administrator {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

class Administrators : ObservableObject {
    @Published var administrators = [Administrator]()
}
