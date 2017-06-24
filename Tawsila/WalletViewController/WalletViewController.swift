//
//  WalletViewController.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet var viewEng: UIView!
    @IBOutlet var viewArabic: UIView!
    var headerTitlesPayments : NSMutableArray = []

    @IBOutlet var tblWallet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        headerTitlesPayments = [["image" :  "dollor", "key":"Cash"],["image" : "wallet", "key": "Add credit card"]]
        
    }
    override func viewWillAppear(_ animated: Bool) {
          setShowAndHideViews(viewEng, vArb: viewArabic)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.headerTitlesPayments.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "WalletViewControllerCustomCellTableView"
        var cell: WalletViewControllerCustomCellTableView! = tableView.dequeueReusableCell(withIdentifier: identifier) as? WalletViewControllerCustomCellTableView
        if cell == nil
        {
            tableView.register(UINib(nibName: "WalletViewControllerCustomCellTableView", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? WalletViewControllerCustomCellTableView
        }
         let dic = headerTitlesPayments[indexPath.row] as! NSDictionary
        if  AppDelegateVariable.appDelegate.strLanguage == "en" {
            cell.lblTitleCash.text = dic.value(forKey: "key") as! String?
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.imageIconPaymentRight.isHidden  = true
            }
            else{
                cell.imageIconPaymentRight.isHidden = false
            }
            
            cell.imageIconPaymentLeft.image = UIImage.init(named: dic.value(forKey: "image") as! String)?.withRenderingMode(.alwaysTemplate)
            
            cell.imageIconPaymentLeft.tintColor  = UIColor.lightGray
        }else{
            cell.lblTitleCashAr.text = dic.value(forKey: "key") as! String?
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.imageIconPaymentRightAr.isHidden  = true
            }
            else{
                cell.imageIconPaymentRightAr.isHidden = false
            }
            
            cell.imageIconPaymentLeftAr.image = UIImage.init(named: dic.value(forKey: "image") as! String)?.withRenderingMode(.alwaysTemplate)
            
            cell.imageIconPaymentLeftAr.tintColor  = UIColor.lightGray
        }
     
        
        return cell
    }

    @IBAction func actionRightMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }
    @IBAction func actionLeftMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
}
