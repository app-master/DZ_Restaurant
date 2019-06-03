//
//  MenuItemDetailViewController.swift
//  DZ_Restaurant
//
//  Created by user on 03/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = String(format: "$%.2f", menuItem.price)
        nameLabel.text = menuItem.name
        detailLabel.text = menuItem.detailText
    }
    
    @IBAction func actionAddToOrder(sender: UIButton) {
        print(#line, #function)
    }

}
