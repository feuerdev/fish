//
//  PickByCoordinateViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 20.10.20.
//

import UIKit

class PickByCoordinateViewController : UIViewController {
    
    @IBOutlet weak var edtCoord: UITextField!
    private var useCaseInput: PickCoordinateUseCaseInput?
    
    convenience init(useCaseInput: PickCoordinateUseCaseInput) {
        self.init()
        self.useCaseInput = useCaseInput
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        useCaseInput?.search(coordinate: edtCoord.text!)
    }
    
    override func viewDidLoad() {
        edtCoord.placeholder = "Coordinate"
        edtCoord.text = "9.14012 51.53407"
    }
    
}

