//
//  LeftMenuViewController.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/14/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lblUserDetail: UILabel!
    var arrLeftMenu =  [["image" : "home", "key" : "Home"], ["image" : "myride", "key" : "My rides"], ["image" : "wallet", "key" : "Wallet"], ["image" : "freeRide", "key" : "Get Free Rides"], ["image" : "settings", "key" : "Settings"], ["image" : "contactUs", "key" : "Contact us"],  ["image" : "help", "key" : "Help"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lblUserDetail.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableView Delegate and DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         tableView.register(UINib(nibName: "leftMenuCell", bundle: nil), forCellReuseIdentifier: "cellLeftMenu")
        var cell : leftMenuCell = tableView.dequeueReusableCell(withIdentifier: "cellLeftMenu", for: indexPath) as! leftMenuCell
        
        if cell == nil{
            cell = tableView.dequeueReusableCell(withIdentifier: "cellLeftMenu", for: indexPath) as! leftMenuCell
        }
        let dic = arrLeftMenu[indexPath.row] as NSDictionary
        cell.imgIcon.image = UIImage.init(named:  dic.value(forKey: "image")! as! String)
        cell.lblTitle.text = dic.value(forKey: "key") as! String?
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
        
        switch indexPath.row {
        case 0:
             let obj : HomeViewControlle = HomeViewControlle(nibName: "HomeViewControlle", bundle: nil)
           SlideNavigationController.sharedInstance().popToRootAndSwitch(to: obj, withCompletion: nil)
        case 1:
           
             let obj : MyRidesVC = MyRidesVC(nibName: "MyRidesVC", bundle: nil)

             SlideNavigationController.sharedInstance().popToRootAndSwitch(to: obj, withCompletion: nil)
        case 2:
          let obj : WalletViewController = WalletViewController(nibName: "WalletViewController", bundle: nil)
               SlideNavigationController.sharedInstance().popToRootAndSwitch(to: obj, withCompletion: nil)
        case 3:
           // moveViewController = UIViewController.init(nibName: "MyRidesVC", bundle: nil)  as!
            print("Get free rides")
        case 4:
              let obj : SettingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: obj, withCompletion: nil)
        case 5:
//            moveViewController = UIViewController.init(nibName: "MyRidesVC", bundle: nil) as! MyRidesVc
            print("Contact Sceen design.")
        case 6:
            print("help Screen design")
        default:
            print("ViewController not Found.")
        }
        }
}
