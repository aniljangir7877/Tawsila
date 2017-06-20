//
//  SignInViewController.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 10/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import RappleProgressHUD

class SignInViewController: UIViewController {

    @IBOutlet var btnDriver: UIButton!
    @IBOutlet var imgDriver: UIImageView!
    @IBOutlet var imgRider: UIImageView!
    @IBOutlet var btnRider: UIButton!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var txtPass: UITextField!
    var userType : String = "user"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
         btnSignIn.layer.cornerRadius = 4.0
        btnSignIn.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionDriver(_ sender: Any) {
        userType = "driver"
        imgDriver.image = UIImage.init(named: "selectRadio")
        imgRider.image = UIImage.init(named: "unselectRadio")
    }
    @IBAction func actionRider(_ sender: Any) {
        userType = "user"
        imgDriver.image = UIImage.init(named: "unselectRadio")
        imgRider.image = UIImage.init(named: "selectRadio")
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        let obj : ChangePasswordViewController = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        navigationController?.pushViewController(obj, animated: true)
        
    }
    @IBAction func actionBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        
        if  Reachability.isConnectedToNetwork() == false
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Internet Connection not Availabel!", controller: self)
            return
        }
        
        if (Utility.sharedInstance.trim(txtEmail.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter your email.", controller: self)
            return
        }
        
        if (AppDelegateVariable.appDelegate.isValidEmail(txtEmail.text!) == false)
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter valid email.", controller: self)
            return
        }
        
        if (Utility.sharedInstance.trim(txtPass.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter password.", controller: self)
            return
        }
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        
        let parameterString = String(format : "login&email=%@&password=%@&usertype=%@&device_id=123456789",self.txtEmail.text! as String,self.txtPass.text! as String,userType)
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                var userDict = (dataDictionary.object(forKey: "result") as! NSDictionary).mutableCopy() as! NSMutableDictionary
                userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict) as! NSMutableDictionary
                
                USER_DEFAULT.set("1", forKey: "isLogin")
                USER_DEFAULT.set(userDict, forKey: "userData")
              
                
                //print("Location:  \(userInfo)")
               /// NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: (userInfo as AnyObject) as? [AnyHashable : Any])
               // AppDelegateVariable.appDelegate.loginInMainView()
                
                
            }
            else
                
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
            
        }
        
        
    }
//        let obj : HomeViewControlle = HomeViewControlle(nibName: "HomeViewControlle", bundle: nil)
//        navigationController?.pushViewController(obj, animated: true)
   // }

}
