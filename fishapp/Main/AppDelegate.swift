//
//  AppDelegate.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 18.10.20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        self.window = UIWindow()
        guard let window = self.window else {
            return true
        }
        
        window.tintColor = tintColor
        
        window.rootViewController = PickLocationRouter.createModule()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        return true
    }
}
