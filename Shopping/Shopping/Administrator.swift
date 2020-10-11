//
//  Administrator.swift
//  Shopping
//
//  Created by Kayla Fang on 10/11/20.
//  Copyright © 2020 Kayla Fang. All rights reserved.
//

import Foundation

class Administrator: Codable  {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

class Administrators : ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case administrators
    }
    @Published var administrators = [Administrator]()
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        administrators = try container.decode([Administrator].self, forKey: .administrators)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(administrators, forKey: .administrators)
    }
}
