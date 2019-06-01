//
//  OrderViewController.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    var selectedIDs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerManager.manager.submitOrder(forMenuIds: selectedIDs) { time, error in
            guard let time = time else {
                if let error = error {
                    print(error.description)
                }
                return
            }
            print("Preparation time: \(time)")
        }
    }
    
}
