//
//  AnimalDetailViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    var animal: Animal?
    
    convenience init(animal: Animal) {
        self.init()
        self.animal = animal
    }
    
}
