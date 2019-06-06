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
        adjustSizes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transition(to: view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        transition(to: size)
    }
    
    func setupUI() {
        navigationItem.title = String(format: "$%.2f", menuItem.price)
        nameLabel.text = menuItem.name
        detailLabel.text = menuItem.detailText
    }
    
    func transition(to size: CGSize) {
        topStackView.axis = size.width < size.height ? .vertical :.horizontal
    }
    
    @IBAction func actionAddToOrder(sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            sender.transform = CGAffineTransform.identity
        }
        
       let orderManager = OrderManager.manager
       orderManager.appendItemToOrder(item: menuItem)
    }

}

extension MenuItemDetailViewController: SizeAdjustable {}
