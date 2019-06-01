//
//  ServerManager.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

final class ServerManager {
    
    static let manager = ServerManager()
    let baseURL = URL(string: "http://server.getoutfit.ru:8090")!
    
    private init() {}
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        
        let categoriesURL = baseURL.appendingPathComponent("categories")
        
        URLSession.shared.dataTask(with: categoriesURL) { data, _, _ in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let categories = try? JSONDecoder().decode(Categories.self, from: data)
            completion(categories?.items)
            
        }.resume()
        
    }
    
}
