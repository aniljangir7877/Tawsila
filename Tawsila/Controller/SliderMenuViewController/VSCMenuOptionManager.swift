//
//  VSCMenuOptionManager.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/11/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
enum VSCMenuOptions {
    case Audi
    case BMW
    case Honda
    case Tata
    case Toyota
    case Suzuki
    case Nissan
    case Volkswagen
    case Volvo
    case Jaguar
    case Fiat
    case Ford
    
    var menuTitle: String {
        
        return String(describing: self)
    }
    
}
class VSCMenuOptionManager: NSObject {
    
    static let sharedInstance = VSCMenuOptionManager()
    
    let slidingPanel: VSCSlidingPanelViewController
    
    
    override init() {
        
        self.slidingPanel = VSCSlidingPanelViewController()
        
        super.init()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  lefthamburgerMenuController : VSCMenuViewController = storyboard.instantiateViewController(withIdentifier: "VSCMenuViewController") as! VSCMenuViewController
        
        let  righthamburgerMenuController : VSCMenuViewController = storyboard.instantiateViewController(withIdentifier: "VSCMenuViewController") as! VSCMenuViewController
        
        
        let  detailController : VSCDetailViewController = storyboard.instantiateViewController(withIdentifier: "VSCDetailViewController") as! VSCDetailViewController
        let navigation = UINavigationController(rootViewController:detailController)
        
        self.slidingPanel.leftPanel = lefthamburgerMenuController
        self.slidingPanel.centerPanel = navigation
        self.slidingPanel.rightPanel = righthamburgerMenuController
        
        lefthamburgerMenuController.menuSelectionClosure = {[weak self](selectedMenuOption: VSCMenuOptions, animated:Bool) in
            
            self?.showScreenForMenuOption(menuOntion: selectedMenuOption, animation: animated)
        }
        
        righthamburgerMenuController.menuSelectionClosure = {[weak self](selectedMenuOption: VSCMenuOptions, animated:Bool) in
            
            self?.showScreenForMenuOption(menuOntion: selectedMenuOption, animation: animated)
        }
        
        
    }
    
    func showScreenForMenuOption(menuOntion: VSCMenuOptions, animation animated: Bool) {
        
        
        let navigationController = self.slidingPanel.centerPanel as! UINavigationController
        let detailController = navigationController.viewControllers.first as! VSCDetailViewController
        detailController.logoImageView.image = UIImage(named: menuOntion.menuTitle)
        
        self.slidingPanel.showCenterPanel(animated: animated)
        
    }
}
