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
    let IDENTIFIER_HEADER = "FamilyListHeader"
    
    var presenter: FamilyListPresenter?
    var loadingView: FamilyListLoadingView?
    var groups = Dictionary<Danger, [Family]>()
    var collapsed = [false, true, false] //Start with Yellow Animals hidden
    
    override func viewDidLoad() {
        self.title = "Families"
        
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets = .init(top: 10, left: 0, bottom: 0, right: 0)
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter?.viewDidLoad()
        
        self.collectionView.isSkeletonable = true
        self.collectionView.showAnimatedSkeleton(usingColor: skeletonColor)
        
        let cell = UINib(nibName: IDENTIFIER_CELL, bundle: nil)
        let header = UINib(nibName: IDENTIFIER_HEADER, bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: IDENTIFIER_CELL)
        self.collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IDENTIFIER_HEADER)
        
        self.collectionView.backgroundColor = .white

        self.loadingView = FamilyListLoadingView(centerIn: UIApplication.shared.keyWindow!)
        
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(named: "icon_info"), style: .plain, target: self, action: #selector(infoTapped))
    }
    
    @objc func infoTapped() {
        self.navigationController?.pushViewController(InfoViewController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideLoadingView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.isSkeletonable {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        guard let danger = Danger(rawValue: section),
              let families = self.groups[danger],
              families.count > 0 else {
            //Tableview is Loading or section is empty
            return UIEdgeInsets.zero
        }
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension FamilyListCollectionViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return IDENTIFIER_CELL
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return IDENTIFIER_HEADER
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IDENTIFIER_HEADER, for: indexPath) as! FamilyListHeader
        if let danger = Danger.init(rawValue: indexPath.section),
           let families = self.groups[danger] {
            header.setup(danger: danger, count: families.count, collapsed: collapsed[indexPath.section])
            header.delegate = self
        }
        
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let danger = Danger(rawValue: section),
              let families = self.groups[danger],
              !self.collapsed[section] else {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let danger = Danger(rawValue: section),
              let families = self.groups[danger],
              families.count > 0,
              !collectionView.isSkeletonable else {
            //Tableview is Loading or section is empty
            return CGSize.zero
        }
        return CGSize(width: collectionView.frame.width, height: CGFloat(40.0))
    }
    
}

extension FamilyListCollectionViewController: AnimalListPresenterDelegate {
    
    func refreshCells() {
        
        if let animals = self.presenter?.interactor?.animals {
            self.groups = Dictionary(grouping: animals) { (animal) -> Danger in
                return animal.danger
            }
        }
        
        self.collectionView.reloadData()
    }
    
    func showError(_ error: String) {
        self.showSimpleError(title: "Oops 🐙", message: error, popViewController: true)
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

extension FamilyListCollectionViewController: FamilyListHeaderDelegate {
    func didCollapse(danger: Danger, collapsed: Bool) {
        self.collapsed[danger.rawValue] = collapsed
        self.collectionView.reloadSections(.init(integer: danger.rawValue))
    }
}
