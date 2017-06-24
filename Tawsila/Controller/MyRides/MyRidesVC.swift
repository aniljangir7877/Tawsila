//
//  MyRidesVC.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/13/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import RappleProgressHUD

class MyRidesVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var viewArabic: UIView!
    @IBOutlet var tblMyRides: UITableView!
    @IBOutlet var tblMyRidesAr: UITableView!
    @IBOutlet var viewEnglish: UIView!
    
    var arrayRideData : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tblMyRides.tableFooterView = UIView()
        self.tblMyRidesAr.tableFooterView = UIView()
        self.getAllMyRide()
        setShowAndHideViews(viewEnglish, vArb: viewArabic)
    }
    
    func getAllMyRide()
    {
        if  Reachability.isConnectedToNetwork() == false
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Internet Connection not Availabel!", controller: self)
            return
        }
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        
        let parameterString = String(format : "get_user_booking&username=%@",((USER_DEFAULT.object(forKey: "userData") as! NSDictionary).object(forKey: "username") as? String)!)
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                let userDict = dataDictionary.object(forKey: "result") as! NSArray
                
                print(userDict.count)
                print(userDict)
                if msg == "No record found"
                {
                    Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
                }
                else
                {
                    self.arrayRideData = userDict.mutableCopy()  as! NSMutableArray
                    if AppDelegateVariable.appDelegate.strLanguage == "en"{
                        self.tblMyRides.reloadData()
                    }else {
                        self.tblMyRidesAr.reloadData()
                    }
                }
            }
            else {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
        }
    }
    
    //MARK :- UITableViewDelegate and DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRideData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        tableView.register(UINib(nibName: "MyRidesTableViewCell", bundle: nil), forCellReuseIdentifier: "cellMyRides")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMyRides", for: indexPath) as! MyRidesTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181.0
    }
    //MARK: - UIButtons actions perform  here
    @IBAction func actionLeftMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    
    @IBAction func actionRightMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }
    
    @IBAction func actionCurrent(_ sender: Any) {
        
    }
    
    @IBAction func actionCompelted(_ sender: Any) {
        
    }
    
    @IBAction func actionScheduled(_ sender: Any) {
        
    }
    
}
