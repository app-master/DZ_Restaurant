//
//  UIViewController+Extension.swift
//  DZ_Restaurant
//
//  Created by user on 07/06/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWith(title: String?, message: String?, confirm: @escaping (UIAlertAction) -> Void, cancel: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { action in
            confirm(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            if let cancel = cancel {
                cancel(action)
            }
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
