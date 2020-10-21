//
//  AnimalListViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import UIKit

class AnimalListViewController : UITableViewController {
    
    var animals = [Animal]()
    
    convenience init(animals: [Animal]) { //If we have a presentation layer you would pass the presenter in the init
        self.init()
        self.animals = animals
    }
    
    override func viewDidLoad() {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
        //TODO: presenter.numberOfRowsInSection()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //TODO: return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = animals[indexPath.row].family
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AnimalDetailViewController(animal:animals[indexPath.row]), animated: true) //TODO: Should this be handled by the router?
    }
    
}
