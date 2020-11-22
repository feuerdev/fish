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
        
        presenter?.viewDidLoad()
        
        tvSpecies.dataSource = self
        let nib = UINib(nibName: "SpeciesListCell", bundle: nil)
        tvSpecies.register(nib, forCellReuseIdentifier: "SpeciesListCell")
        vImageContainer.layer.cornerRadius = 10
        ivPhoto.layer.cornerRadius = 10
        
        lblVernacular.text = presenter!.interactor.family.vernacular
        lblScientific.text = presenter!.interactor.family.family
        lblTaxonHierarchy.text = presenter!.presentableHierarchy()
        lblSightings.text = presenter?.presentableSightings()
        if let photoFileName = presenter?.interactor.family.photoFileName {
            ivPhoto.loadImagefromDocuments(filename: photoFileName)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        conTvHeight.constant = tvSpecies.contentSize.height
    }
}

extension AnimalDetailViewController: AnimalDetailPresenterDelegate {
    func refreshCell(indexPath: IndexPath) {
        self.tvSpecies.reloadRows(at: [indexPath], with: .automatic)
        conTvHeight.constant = tvSpecies.contentSize.height
    }
}

extension AnimalDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.interactor.family.species.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvSpecies.dequeueReusableCell(withIdentifier: "SpeciesListCell", for: indexPath) as! SpeciesListCell
        guard let species = presenter?.interactor.family.species[indexPath.row] else {
            return cell
        }
        
        cell.species = species
        
        return cell
    }
}
