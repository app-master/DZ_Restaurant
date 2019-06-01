//
//  MenuItemsTableViewController.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class MenuItemsTableViewController: UITableViewController {

    @IBOutlet weak var addOrderButtonItem: UIBarButtonItem!
    
    var categoryName: String!
    var menuItemArray = [MenuItem]()
    var selectedIDs = [Int]() {
        didSet {
            if selectedIDs.count > 0 {
                self.addOrderButtonItem.isEnabled = true
            } else {
                self.addOrderButtonItem.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = categoryName.capitalized
        
        tableView.tableFooterView = UIView(frame: .zero)
        
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
    
// MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowOrderId" else { return }
        
        let vc = segue.destination as! OrderViewController
        vc.selectedIDs = selectedIDs
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

// MARK: - UITableViewDelegate

extension MenuItemsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let menuItem = menuItemArray[indexPath.row]
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            selectedIDs.append(menuItem.id)
        } else {
            cell.accessoryType = .none
            if let index = selectedIDs.firstIndex(of: menuItem.id) {
                selectedIDs.remove(at: index)
            }
        }
    }
    
}
