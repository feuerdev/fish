//
//  AnimalDetailViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import UIKit
import Feuerlib

class FamilyDetailViewController: UIViewController {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblTaxonHierarchy: UILabel!
    @IBOutlet weak var lblSightings: UILabel!
    @IBOutlet weak var tvSpecies: UITableView!
    @IBOutlet weak var conTvHeight: NSLayoutConstraint!
    var presenter: FamilyDetailPresenter?
    
    override func viewDidLoad() {
        
        guard self.presenter != nil else {
            return
        }
        
        presenter?.viewDidLoad()
        
        tvSpecies.dataSource = self
        
        let nib = UINib(nibName: "SpeciesListCell", bundle: nil)
        tvSpecies.register(nib, forCellReuseIdentifier: "SpeciesListCell")
        
        lblScientific.text = presenter!.interactor.family.family
        lblTaxonHierarchy.text = presenter!.presentableHierarchy()
        
        LoadVernacularService.loadVernacular(id: presenter!.interactor.family.familyId) { result in
            switch result {
            case .failure(_):
                break
            case .success(let result):
                DispatchQueue.main.async {
                    self.lblVernacular.text = result.vernacular
                    self.lblVernacular.hideSkeleton()
        }
    }
        }
    
        if let searchTerm = presenter!.interactor.family.family {
            LoadPhotoService.loadPhoto(id: presenter!.interactor.family.familyId, searchParameter: searchTerm) { result in
                switch result {
                case .failure(_):
                    break
                case .success(let result):
                    ImageCache.shared.getImage(from: result.url) { [weak self] result in
                        guard let self = self else {
                            return
                        }
                        switch result {
                        case .success((_, let image)):
                            DispatchQueue.main.async() {
                                self.ivPhoto.image = image
                                self.ivPhoto.hideSkeleton()
                            }
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateSpeciesTableHeightConstraint()
    }
}

extension FamilyDetailViewController: FamilyDetailPresenterDelegate {
    //
}


extension FamilyDetailViewController: UITableViewDataSource {
    
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
