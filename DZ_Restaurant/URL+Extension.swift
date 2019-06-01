//
//  URL+Extension.swift
//  DZ_Restaurant
//
//  Created by user on 01/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

extension URL {
    
    func urlWithQueryItems(forParams params: [String : String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = params.map { (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
        
        return components?.url
        
    }
    
}
