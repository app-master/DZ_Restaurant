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
        
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: .AddedItemToOrder, object: nil)
    }

    
    
}

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
}
