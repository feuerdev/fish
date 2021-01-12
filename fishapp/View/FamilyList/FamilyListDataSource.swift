//
//  FamilyListDatasource.swift
//  big-pond
//
//  Created by Jannik Feuerhahn on 12.01.21.
//

import Foundation
import SkeletonView

protocol FamilyListDataSourceDelegate:AnyObject {
    func familySelected(_ family:Family)
}

class FamilyListDataSource: NSObject {
    weak var delegate:FamilyListDataSourceDelegate?
    var groups = Dictionary<Danger, [Family]>()
    var collapsed = [false, true, false] //Start with Yellow Animals hidden
}
    
extension FamilyListDataSource:SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return IDENTIFIER_FAMILY_CELL
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return IDENTIFIER_FAMILY_HEADER
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let danger = Danger(rawValue: section),
              let families = self.groups[danger],
              !self.collapsed[section] else {
            return 0
        }
        return families.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIER_FAMILY_CELL, for: indexPath) as! FamilyListCell
        
        guard let danger = Danger(rawValue: indexPath.section),
            let families = self.groups[danger],
            let family = families[safe: indexPath.row] else {
            return cell
        }
        
        cell.setFamily(family)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IDENTIFIER_FAMILY_HEADER, for: indexPath) as! FamilyListHeader
        guard let danger = Danger.init(rawValue: indexPath.section),
           let families = self.groups[danger] else {
            return header
        }
        header.danger = danger
        header.count = families.count
        header.collapsed = collapsed[indexPath.section]
        header.onCollapse = { danger, collapsed in
            print(collapsed)
            self.collapsed[danger.rawValue] = collapsed
            collectionView.reloadSections(.init(integer: danger.rawValue))
        }
        return header
    }
}

extension FamilyListDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let danger = Danger(rawValue: indexPath.section),
              let families = self.groups[danger],
            let family = families[safe: indexPath.row] else {
            return
        }
        
        delegate?.familySelected(family)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 30
        let fullWidth = collectionView.frame.width - padding
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
