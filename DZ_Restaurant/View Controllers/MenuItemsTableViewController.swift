//
//  MenuItemsTableViewController.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class MenuItemsTableViewController: UITableViewController {
    
    var category: String!
    var menuItemArray = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = category.capitalized
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        let serverManager = ServerManager.manager
        
        serverManager.fetchMenuItems(forCategory: category) { (results, error) in
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
        
        CellManager.configureCell(cell, withMenuItem: menuItem)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MenuItemsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMenuItem = menuItemArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuItemDetailViewController") as! MenuItemDetailViewController
        
        vc.menuItem = selectedMenuItem
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
