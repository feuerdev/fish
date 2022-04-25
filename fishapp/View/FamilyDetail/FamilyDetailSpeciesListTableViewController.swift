//
//  FamilyDetailSpeciesListTableViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import UIKit

class FamilyDetailSpeciesListTableViewController: UITableViewController {

    var presenter: FamilyDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "FamilyDetailSpeciesListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "FamilyDetailSpeciesListCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.allowsSelection = false

        // Hide extra dividers
        self.tableView.hideAdditionalDividers()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.interactor.family.species.count else {
            return 0
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyDetailSpeciesListCell", for: indexPath) as! FamilyDetailSpeciesListCell
        guard let species = presenter?.interactor.family.species[indexPath.row] else {
            return cell
        }

        cell.species = species

        return cell
    }
}
