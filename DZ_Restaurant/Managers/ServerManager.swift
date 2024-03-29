//
//  ServerManager.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

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
    
    func fetchMenuItems(forCategory category: String, completion: @escaping ([MenuItem]?, NetworkError?) -> Void) {
        
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
    
    func submitOrder(forMenuIds ids: [Int], completion: @escaping (Int?, NetworkError?) -> Void) {
        
        let orderURL = baseURL.appendingPathComponent("order")
        
        let params = ["menuIds" : ids]
        
        var request = URLRequest(url: orderURL)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        guard let dataIDs = data else {
            completion(nil, .badData)
            return
        }
        
        request.httpBody = dataIDs
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(nil, .badData)
                return
            }
                        
            do {
                let prepTime = try JSONDecoder().decode(PreparationTime.self, from: data)
                completion(prepTime.time, nil)
            } catch {
                completion(nil, .badDecode)
            }
        }.resume()
        
    }
    
    func fetchImage(byURL url: URL, completion:@escaping (UIImage?) -> Void) {
        
        guard let globalURL = url.utlByReplacingOfHost(baseURL.host!) else {
            completion(nil)
            return
        }
         
        URLSession.shared.dataTask(with: globalURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
        
    }
    
}
