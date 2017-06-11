//
//  VSCMenuViewController.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/11/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class VSCMenuViewController: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    let cellID = "MenuOptionTableViewCell"
    let menuItems = [VSCMenuOptions.Audi, VSCMenuOptions.BMW, VSCMenuOptions.Honda, VSCMenuOptions.Tata, VSCMenuOptions.Toyota, VSCMenuOptions.Suzuki,VSCMenuOptions.Nissan, VSCMenuOptions.Volkswagen, VSCMenuOptions.Volvo, VSCMenuOptions.Jaguar, VSCMenuOptions.Fiat, VSCMenuOptions.Ford]
    var menuSelectionClosure: ((VSCMenuOptions, Bool)-> Void)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

//MARK: UITableViewDelegate

extension VSCMenuViewController:UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let menuItem = self.menuItems[indexPath.row]
        self.menuSelectionClosure(menuItem, true)
    }
    
}


//MARK: UITableViewDataSource

extension VSCMenuViewController:UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let menuItem = self.menuItems[indexPath.row]
        
        cell.textLabel?.text = menuItem.menuTitle
        return cell
    }
    
}


