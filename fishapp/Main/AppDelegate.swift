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
        
        window.rootViewController = PickLocationRouter.createModule()
        
        setStyle()
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func setStyle() {
        guard let window = self.window,
              let navigationController = window.rootViewController as? UINavigationController else {
            return
        }
        
        window.backgroundColor = .white
        window.tintColor = tintColor
        
        
        navigationController.navigationBar.barTintColor = tintColor
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
