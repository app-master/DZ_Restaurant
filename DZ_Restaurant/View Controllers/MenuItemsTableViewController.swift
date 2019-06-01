//
//  MenuItemsTableViewController.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class MenuItemsTableViewController: UITableViewController {

    var categoryName: String!
    var menuItemArray = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = categoryName.capitalized
        
        let serverManager = ServerManager.manager
        
        serverManager.fetchMenuItems(forCategoryName: categoryName) { (results, error) in
            guard let results = results else {
                if let error = error {
                    print(error.description)
                }
                return
            }
            self.menuItemArray += results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension MenuItemsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "MenuItemCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let menuItem = menuItemArray[indexPath.row]
        
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = menuItem.category
        
        return cell
    }
    
}
