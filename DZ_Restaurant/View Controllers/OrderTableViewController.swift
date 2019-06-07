//
//  OrderTableViewController.swift
//  DZ_Restaurant
//
//  Created by user on 06/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        navigationItem.leftBarButtonItem = editButtonItem
        NotificationCenter.default.addObserver(tableView!,
                                               selector: #selector(UITableView.reloadData),
                                               name: .AddedItemToOrder, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: .AddedItemToOrder,
                                                  object: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension OrderTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.manager.countItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "OrderCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let item = OrderManager.manager.getItemFromOrder(at: indexPath.row)
        
        CellManager.configureCell(cell, withMenuItem: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            OrderManager.manager.removeItemFromOrder(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension OrderTableViewController {
    
}
