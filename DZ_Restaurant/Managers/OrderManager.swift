//
//  OrderManager.swift
//  DZ_Restaurant
//
//  Created by user on 06/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import Foundation

final class OrderManager {
    
   private class Order {
        var items: [MenuItem]
        
        init(items: [MenuItem] = []) {
            self.items = items
        }
    }
    
    static let manager = OrderManager()
    
    private var order = Order()
    
    var countItems: Int {
        return order.items.count
    }
    
    private init() {}
    
    func appendItemToOrder(item: MenuItem) {
        order.items.append(item)
        NotificationCenter.default.post(name: .AddedItemToOrder, object: nil)
    }
    
    func removeItemFromOrder(at index: Int) {
        order.items.remove(at: index)
        NotificationCenter.default.post(name: .RemovedItemFromOrder, object: nil)
    }
    
    func getItemFromOrder(at index: Int) -> MenuItem {
       return order.items[index]
    }
    
}
