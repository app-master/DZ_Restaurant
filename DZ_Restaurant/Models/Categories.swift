//
//  Categories.swift
//  DZ_Restaurant
//
//  Created by user on 01/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

struct Categories: Decodable {
    let items: [String]
    
    enum CodingKeys: String, CodingKey {
        case items = "categories"
    }
}
