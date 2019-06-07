//
//  PerformanceViewController.swift
//  DZ_Restaurant
//
//  Created by user on 07/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitOrder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let tbc = tabBarController as? TabBarController {
            tbc.orderItem?.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        if let tbc = tabBarController as? TabBarController {
            tbc.orderItem?.isEnabled = true
        }
    }
    
    private func submitOrder() {
        activityIndicator.startAnimating()
        let selectedIds = OrderManager.manager.selectedIds
        ServerManager.manager.submitOrder(forMenuIds: selectedIds) { time, error in
            var text = ""
            if let time = time {
                text = "Time to preparation: \(time) min."
                DispatchQueue.main.async {
                    OrderManager.manager.removeAllItemsFromOrder()
                }
            } else {
                if let error = error {
                    text = error.description
                }
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.preparationTimeLabel.text = text
                self.stackView.isHidden = false
            }
        }
    }
    
}
