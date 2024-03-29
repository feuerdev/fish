//
//  AppDelegate.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 18.10.20.
//

import UIKit
import Firebase

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

        FirebaseApp.configure()

        return true
    }

    func setStyle() {
        guard let window = self.window,
              let navigationController = window.rootViewController as? UINavigationController else {
            return
        }

        window.backgroundColor = backGroundColor2
        window.tintColor = pondColor

        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light

            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = pondColor
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController.navigationBar.standardAppearance = navBarAppearance
            navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = pondColor
        navigationController.navigationBar.tintColor = textTintColor

        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor]

        // Color of "cancel" button in search bar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): pondColor], for: .normal)

    }
}
