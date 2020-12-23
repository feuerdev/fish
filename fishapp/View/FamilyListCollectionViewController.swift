//
//  FamilyListCollectionViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit
import SkeletonView
import Feuerlib

class FamilyListCollectionViewController: UICollectionViewController {
    
    let IDENTIFIER_CELL = "FamilyListCell"
    
    var presenter: FamilyListPresenter?
    var loadingView: FamilyListLoadingView?
    var groups = Dictionary<Danger, [Family]>()
    
    override func viewDidLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter?.viewDidLoad()
        
        self.collectionView.isSkeletonable = true
        self.collectionView.showAnimatedSkeleton(usingColor: .wetAsphalt)
        
        let nib = UINib(nibName: IDENTIFIER_CELL, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: IDENTIFIER_CELL)
        self.collectionView.backgroundColor = .white

        self.loadingView = FamilyListLoadingView(centerIn: UIApplication.shared.keyWindow!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideLoadingView()
    }
    
    //MARK: - Datasource
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension FamilyListCollectionViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return IDENTIFIER_CELL
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let danger = Danger(rawValue: indexPath.section),
            let families = self.groups[danger],
            let family = families[safe: indexPath.row] else {
            return
        }
        presenter?.didSelectFamily(family)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIER_CELL, for: indexPath) as! FamilyListCell
        
        guard let danger = Danger(rawValue: indexPath.section),
            let families = self.groups[danger],
            let family = families[safe: indexPath.row] else {
            return cell
        }
        
        cell.setFamily(family)
        
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let danger = Danger(rawValue: section),
              let families = self.groups[danger] else {
            return 0
        }
        return families.count
    }
}

extension FamilyListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 30
        let fullWidth = self.collectionView.frame.width - padding
        return CGSize(width: fullWidth/2, height: fullWidth/2)
    }
}

extension FamilyListCollectionViewController: AnimalListPresenterDelegate {
   
    func refreshCells() {
    
        if let animals = self.presenter?.interactor?.animals {
            self.groups = Dictionary(grouping: animals) { (animal) -> Danger in
                return animal.danger
            }
    }
    
    func refreshCells() {
        self.collectionView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func updateLoadingStatus(percent: Float) {
        self.loadingView?.pvProgress.setProgress(percent, animated: true)
    }
    
    func updateLoadingStatus(status: String) {
        self.loadingView?.lblProgress.text = status
    }
    
    func hideLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.loadingView?.isHidden = true
        self.collectionView.stopSkeletonAnimation()
        self.collectionView.hideSkeleton()
        self.collectionView.isSkeletonable = false
    }
}
