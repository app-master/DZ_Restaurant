//
//  AppDelegate.swift
//  DZ_Restaurant
//
//  Created by user on 31/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupURLCache()
        
        return true
    }
    
    func setupURLCache() {
      let directory = NSTemporaryDirectory()
      let urlCache = URLCache(memoryCapacity: 250_000, diskCapacity: 5_000_000, diskPath: directory)
      URLCache.shared = urlCache
    }
    
}

