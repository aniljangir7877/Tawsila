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

    @IBOutlet var tblMyRides: UITableView!
    var arrayRideData : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblMyRides.tableFooterView = UIView()
        self.getAllMyRide()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
            
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
                    self.tblMyRides.reloadData()
                }
               
                
                
            }
            else
                
            {
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
    
    @IBAction func actionLeftMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
}
