//
//  AnimalDetailViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import UIKit
import Feuerlib

class FamilyDetailViewController: UIViewController {
    

    @IBOutlet var svContent: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stvContent: UIStackView!
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblNoPhoto: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblTaxonHierarchy: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var tvSpecies: UITableView!
    @IBOutlet weak var conTableHeight: NSLayoutConstraint!
    var presenter: FamilyDetailPresenter?
    
    override func viewDidLoad() {
        self.title = "Family"
        
        self.view.backgroundColor = tintColor
        self.lblVernacular.textColor = textTintColor
        self.lblScientific.textColor = textTintColor
        self.lblTaxonHierarchy.textColor = textTintColor
        self.lblSpecies.textColor = textTintColor
        self.lblNoPhoto.textColor = textTintColor

        guard self.presenter != nil else {
            return
        }
        
        presenter?.viewDidLoad()
        
        tvSpecies.dataSource = self
        
        let nib = UINib(nibName: "SpeciesListCell", bundle: nil)
        tvSpecies.register(nib, forCellReuseIdentifier: "SpeciesListCell")
        
        lblScientific.text = presenter!.interactor.family.family
        lblTaxonHierarchy.text = presenter!.presentableHierarchy()
        
        self.ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        
        self.lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        
        LoadVernacularService.loadVernacular(id: presenter!.interactor.family.familyId) { result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.lblVernacular.text = self.presenter!.interactor.family.family
                    self.lblScientific.isHidden = true
                    self.lblVernacular.hideSkeleton()
                }
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
                    self.showNoPhoto(family: self.presenter!.interactor.family)
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
    
    func showNoPhoto(family:Family) {
        DispatchQueue.main.async() {
            self.ivPhoto.image = nil
            self.ivPhoto.hideSkeleton()
            self.ivPhoto.backgroundColor = tintColor
            self.lblNoPhoto.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Update the height constraint of the table view. I think this is necessary because the table view is inside a stack view
        conTableHeight.constant = tvSpecies.contentSize.height
        
        //Then call layout if needed on said stack view to update its frame
        stvContent.layoutIfNeeded()
        
        //Finally manually set the content size of the parent scroll view to the newly calculated stack view height
        svContent.contentSize = CGSize(width: svContent.frame.width, height: stvContent.frame.height)
    }
}

extension FamilyDetailViewController: FamilyDetailPresenterDelegate {
    //
}


extension FamilyDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.interactor.family.species.count else {
            return 0
        }
        return count
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
