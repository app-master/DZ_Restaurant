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
    
    var totalPrice: Double {
       return order.items.reduce(0) { $0 + $1.price }
    }
    
    var selectedIds: [Int] {
        return order.items.map { $0.id }
    }
    
    private init() {}
    
    func addItemToOrder(_ item: MenuItem) {
        order.items.append(item)
        order.items.sort { $0.id < $1.id }
        NotificationCenter.default.post(name: .AddedItemToOrder, object: nil)
    }
    
    func removeItemFromOrder(at index: Int) {
        order.items.remove(at: index)
        NotificationCenter.default.post(name: .RemovedItemsFromOrder, object: nil)
    }
    
    func removeAllItemsFromOrder() {
        order.items.removeAll()
        NotificationCenter.default.post(name: .RemovedItemsFromOrder, object: nil)
    }
    
    func getItemFromOrder(at index: Int) -> MenuItem {
       return order.items[index]
    }
    
}
