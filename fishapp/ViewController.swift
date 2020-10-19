//
//  ViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 18.10.20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        let xc = NSLayoutConstraint.init(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yc = NSLayoutConstraint.init(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addSubview(label)
        view.addConstraints([xc,yc])
        
        
    }


}

