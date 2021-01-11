//
//  FamilyDetailTabbarController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import UIKit

/**
 This ovverride only exists, to color the statusbar in yellow or red categories
 */
class FamilyDetailTabBarController: UITabBarController {
    
    var presenter: FamilyDetailPresenter?
    
    override func viewDidLoad() {
        self.title = "Family"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let family = self.presenter?.interactor.family else {
            return
        }
        
        self.view.backgroundColor = backGroundColor2
        
//        tabBar.isTranslucent = false
        tabBar.barTintColor = family.getPresentableColor()
        tabBar.tintColor = family.getPresentableTextColor()
        tabBar.unselectedItemTintColor = family.getPresentableInactiveTextColor()
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = family.getPresentableColor()
            navBarAppearance.titleTextAttributes = [.foregroundColor: family.getPresentableTextColor()]
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = family.getPresentableTextColor()
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: family.getPresentableTextColor()]
            navigationController?.navigationBar.barTintColor = family.getPresentableColor()
            navigationController?.navigationBar.tintColor = family.getPresentableTextColor()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = pondColor
            navBarAppearance.titleTextAttributes = [.foregroundColor: textTintColor]
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = textTintColor
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textTintColor]
            navigationController?.navigationBar.barTintColor = pondColor
            navigationController?.navigationBar.tintColor = textTintColor
        }
    }
}
