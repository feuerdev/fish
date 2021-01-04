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
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblNoPhoto: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblTaxonHierarchy: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var tvSpecies: UITableView!
    @IBOutlet weak var conTableHeight: NSLayoutConstraint!
    @IBOutlet weak var vContent: UIView!
    var presenter: FamilyDetailPresenter?
    
    override func viewDidLoad() {
        self.title = "Family"
        
        self.vContent.backgroundColor = backGroundColor2
        self.lblVernacular.textColor = .black
        self.lblScientific.textColor = .black
        self.lblTaxonHierarchy.textColor = .black
        self.lblSpecies.textColor = .black
        self.lblNoPhoto.textColor = .black
        
        self.ivPhoto.layer.cornerRadius = defaultCornerRadius
        self.ivPhoto.layer.borderWidth = 1

        guard let family = self.presenter?.interactor.family else {
            return
        }
    
        presenter?.viewDidLoad()
        
        tvSpecies.dataSource = self
        tvSpecies.estimatedRowHeight = 300
        
        let nib = UINib(nibName: "SpeciesListCell", bundle: nil)
        tvSpecies.register(nib, forCellReuseIdentifier: "SpeciesListCell")
        
        lblScientific.text = family.family
        lblTaxonHierarchy.text = presenter?.presentableHierarchy()
        ivPhoto.layer.borderColor = family.getPresentableColor().cgColor
        
        self.ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        
        self.lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        
        LoadVernacularService.loadVernacular(id: family.familyId) { result in
            switch result.result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.lblVernacular.text = family.family
                    self.lblScientific.isHidden = true
                    self.lblVernacular.hideSkeleton()
                }
                break
            case .success(let name):
                DispatchQueue.main.async {
                    self.lblVernacular.text = name
                    self.lblVernacular.hideSkeleton()
                }
            }
        }
       
        LoadPhotoService.loadPhoto(id: family.familyId, searchParameters: family.generatePhotoSearchterms()) { result in
            switch result.result {
            case .failure(_):
                self.showNoPhoto(family: family)
                break
            case .success(let image):
                DispatchQueue.main.async() {
                    self.ivPhoto.image = image
                    self.ivPhoto.hideSkeleton()
                }
            }
        }
    }
    
    func showNoPhoto(family:Family) {
        DispatchQueue.main.async() {
            self.ivPhoto.image = nil
            self.ivPhoto.hideSkeleton()
            self.ivPhoto.backgroundColor = family.getPresentableColor()
            self.lblNoPhoto.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let family = self.presenter?.interactor.family else {
            return
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        conTableHeight.constant = tvSpecies.contentSize.height
        self.view.layoutIfNeeded()
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
