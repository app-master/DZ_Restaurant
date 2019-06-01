//
//  PreparationTime.swift
//  DZ_Restaurant
//
//  Created by user on 01/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

struct PreparationTime: Decodable {
    var time: Int
    
    enum CodingKeys: String, CodingKey {
        case time = "preparation_time"
    }
}
