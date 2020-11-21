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
    @IBOutlet weak var tvSpecies: UITableView!
    @IBOutlet weak var conTvHeight: NSLayoutConstraint!
    var presenter: AnimalDetailPresenter?
    
    override func viewDidLoad() {
        
        guard self.presenter != nil else {
            return
        }
        tvSpecies.dataSource = self
        vImageContainer.layer.cornerRadius = 10
        ivPhoto.layer.cornerRadius = 10
        
        vImageContainer.backgroundColor = UIColor(hexString: presenter!.presentableDangerColor())
        
        lblVernacular.text = presenter!.animal.vernacular
        lblScientific.text = presenter!.animal.family
        lblTaxonHierarchy.text = presenter!.presentableHierarchy()
        lblSightings.text = presenter?.presentableSightings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        conTvHeight.constant = tvSpecies.contentSize.height
    }
}



extension AnimalDetailViewController: AnimalDetailPresenterDelegate {
    
}

extension AnimalDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.getPresentableSpeciesName(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.animal.species.count {
            return count
        } else {
            return 0
        }
    }
}
