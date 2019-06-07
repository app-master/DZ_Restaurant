//
//  CellManager.swift
//  DZ_Restaurant
//
//  Created by user on 03/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

final class CellManager {
    
    static func configureCell(_ cell: UITableViewCell, withCategory category: String) {
        cell.textLabel?.text = category.capitalized
    }
    
    static func configureCell(_ cell: UITableViewCell, withMenuItem menuItem: MenuItem) {
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        cell.imageView?.image = nil
        
        ServerManager.manager.fetchImage(byURL: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.layoutSubviews()
            }
        }
    }
    
}
