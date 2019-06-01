//
//  ServerManager.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badData
    case badDecode
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badURL: return "Bad URL"
        case .badData: return "Failed to get data"
        case .badDecode: return "Failed to decode data"
        }
    }
}

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
    
    func fetchMenuItems(forCategoryName category: String, completion: @escaping ([MenuItem]?, NetworkError?) -> Void) {
        
        let menuItemsURL = baseURL.appendingPathComponent("menu")
        
        let params = ["category" : category]
        
        guard let finalURL = menuItemsURL.urlWithQueryItems(forParams: params) else {
            completion(nil, .badURL)
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, _) in
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            do {
               let menuItems = try JSONDecoder().decode(MenuItems.self, from: data)
               completion(menuItems.items, nil)
            } catch {
               completion(nil, .badDecode)
            }
        }.resume()
        
    }
    
}
