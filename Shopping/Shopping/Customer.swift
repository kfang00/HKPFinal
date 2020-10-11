//
//  User.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation

class Customer: Codable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

class Customers: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case customers
    }
    @Published var customers = [Customer]()
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        customers = try container.decode([Customer].self, forKey: .customers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(customers, forKey: .customers)
    }
    
}
