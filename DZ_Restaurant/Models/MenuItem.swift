//
//  MenuItem.swift
//  DZ_Restaurant
//
//  Created by user on 01/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

struct MenuItem: Decodable {
    
    var name: String
    var id: Int
    var price: Double
    var imageURL: URL
    var detailText: String
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case price
        case imageURL = "image_url"
        case detailText = "description"
        case category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        price = try container.decode(Double.self, forKey: .price)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        detailText = try container.decode(String.self, forKey: .detailText)
        category = try container.decode(String.self, forKey: .category)
    }
    
}
