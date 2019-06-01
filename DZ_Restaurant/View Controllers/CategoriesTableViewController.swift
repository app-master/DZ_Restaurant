//
//  CategoriesTableViewController.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       tableView.tableFooterView = UIView(frame: .zero)
        
       loadCategories()
    }
    
    private func loadCategories() {
        let serverManager = ServerManager.manager
        
        serverManager.fetchCategories { results in
            guard let results = results else { return }
            self.categories += results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension CategoriesTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let identifier = "CategoryCell"
    
       let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
       let category = categories[indexPath.row]
    
       cell.textLabel?.text = category
    
       return cell
    
    }
}