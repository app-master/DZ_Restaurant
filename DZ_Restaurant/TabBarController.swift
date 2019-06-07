//
//  TabBarController.swift
//  DZ_Restaurant
//
//  Created by user on 07/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    weak var orderItem: UITabBarItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOrderItem()
    }
    
    func setupOrderItem() {
        if let orderItem = tabBar.items?[1] {
            self.orderItem = orderItem
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateOrderBadge),
                                                   name: .AddedItemToOrder,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateOrderBadge),
                                                   name: .RemovedItemsFromOrder,
                                                   object: nil)
        }
    }
    
    @objc private func updateOrderBadge() {
        guard let orderItem = orderItem else { return }
        let count = OrderManager.manager.countItems
        if count > 0 {
            orderItem.badgeValue = String(count)
        } else {
            orderItem.badgeValue = nil
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .AddedItemToOrder,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .RemovedItemsFromOrder,
                                                  object: nil)
    }

}
