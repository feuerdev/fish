//
//  AnimalDetailViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    @IBOutlet weak var vImageContainer: UIView!
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblTaxonHierarchy: UILabel!
    @IBOutlet weak var lblSightings: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    var presenter: AnimalDetailPresenter?
    
    override func viewDidLoad() {
        
        guard self.presenter != nil else {
            return
        }
        vImageContainer.layer.cornerRadius = 10
        ivPhoto.layer.cornerRadius = 10
        
        vImageContainer.backgroundColor = UIColor(hexString: presenter!.presentableDangerColor())
        
        lblVernacular.text = presenter!.animal.vernacular
        lblScientific.text = presenter!.animal.family
        lblTaxonHierarchy.text = presenter!.presentableHierarchy()
        lblCategory.text = presenter!.presentableCategory()
        lblCategory.textColor = UIColor(hexString: presenter!.presentableCategoryColor())
        lblSightings.text = presenter?.presentableSightings()
        
    }
    
}

extension AnimalDetailViewController: AnimalDetailPresenterDelegate {
    
}
