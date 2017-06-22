//
//  forgotPassword.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/17/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import RappleProgressHUD

class forgotPassword: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSendNewPassword(_ sender: Any) {
        if  Reachability.isConnectedToNetwork() == false
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Internet Connection not Availabel!", controller: self)
            return
        }
        if (Utility.sharedInstance.trim(self.txtEmail.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter your email.", controller: self)
            return
        }
        
        if (AppDelegateVariable.appDelegate.isValidEmail(self.txtEmail.text!) == false)
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter valid email.", controller: self)
            return
        }
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        
        let parameterString = String(format : "forgot_password&email=%@",self.txtEmail.text! as String)
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                 Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
              _ =  self.navigationController?.popViewController(animated: true)
//                var userDict = (dataDictionary.object(forKey: "result") as! NSDictionary).mutableCopy() as! NSMutableDictionary
//                userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict) as! NSMutableDictionary
//                
//                USER_DEFAULT.set("1", forKey: "isLogin")
//                USER_DEFAULT.set(userDict, forKey: "userData")
                
                
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:  - UITextFieldDelegate method implemnet
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        

        
    }
    

}
