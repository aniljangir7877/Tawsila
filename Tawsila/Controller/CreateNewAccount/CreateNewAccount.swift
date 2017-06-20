//
//  CreateNewAccount.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/11/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import RappleProgressHUD

class CreateNewAccount: UIViewController {
    @IBOutlet var txtUserFullName: UITextField!
    @IBOutlet var txtemail: UITextField!
    @IBOutlet var txtpassword: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtCountryCode: UITextField!
    @IBOutlet var txtInvitationCode: UITextField!
    @IBOutlet var imgTerm_Conditions: UIImageView!
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var viewEnglish: UIView!
    @IBOutlet var viewArabic: UIView!
    @IBOutlet var btnBack: UIButton!
    
    var isSelect :Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImageView.init(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        img.image  = UIImage.init(named: "dropDown")
        txtCountryCode.rightView?.frame = img.frame
        txtCountryCode.rightViewMode = .always
        txtCountryCode.rightView = img
        btnSignUp.layer.cornerRadius = 4.0
        btnSignUp.layer.masksToBounds = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        isSelect = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIButtons Actions
    @IBAction func actionSignUp(_ sender: Any) {
        
        if  Reachability.isConnectedToNetwork() == false
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Internet Connection not Availabel!", controller: self)
            return
        }
        
        if (Utility.sharedInstance.trim(self.txtUserFullName.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter your Full Name.", controller: self)
            return
        }
        
        if (Utility.sharedInstance.trim(txtemail.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter your email.", controller: self)
            return
        }
        
        if (AppDelegateVariable.appDelegate.isValidEmail(txtemail.text!) == false)
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter valid email.", controller: self)
            return
        }
        
        if (Utility.sharedInstance.trim(txtpassword.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter password.", controller: self)
            return
        }
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
<<<<<<< HEAD
//        let parameter s = [
//             "username" :  self.txtUserFullName.text! as String,
//            "email" :  self.txtemail.text! as String,
//            "password":   self.txtpassword.text! as String,
//            "phone":   self.txtpassword.text! as String,
//            "country_mobile_code" : "91",
//            "terms_and_condition" : "",
//            "device_id" : "123456789"
//            
//        ]
          let parameterString = String(format : "register&username=%@&email=%@&password=%@&mobile=%@&country_mobile_code=%@&terms_and_condition=%@&device_id=%@",self.txtUserFullName.text! as String,self.txtemail.text! as String,self.txtpassword.text! as String,self.txtMobile.text! as String,"91","","1234567890")
=======
        //        let parameters = [
        //             "username" :  self.txtUserFullName.text! as String,
        //            "email" :  self.txtemail.text! as String,
        //            "password":   self.txtpassword.text! as String,
        //            "phone":   self.txtpassword.text! as String,
        //            "country_mobile_code" : "91",
        //            "terms_and_condition" : "",
        //            "device_id" : "123456789"
        //
        //        ]
        let parameterString = String(format : "register&username=%@&email=%@&password=%@&mobile=%@&country_mobile_code=%@&terms_and_condition=%@&device_id=%@",self.txtUserFullName.text! as String,self.txtemail.text! as String,self.txtpassword.text! as String,self.txtMobile.text! as String,"91","","1234567890")
>>>>>>> e0d25e47d49dd5473c751927147f180b243f0428
        Utility.sharedInstance.postDataInDataForm(header: parameterString,  inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                // var userDict = (((dataDictionary.object(forKey: "response") as! NSDictionary).object(forKey: "data")) as! NSDictionary).mutableCopy() as! NSMutableDictionary
                //userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict) as! NSMutableDictionary
                
                //                USER_DEFAULT.set("1", forKey: "isLogin")
                //                USER_DEFAULT.set(userDict, forKey: "userData")
                
                
                //print("Location:  \(userInfo)")
                /// NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: (userInfo as AnyObject) as? [AnyHashable : Any])
                //  AppDelegateVariable.appDelegate.loginInMainView()
                
                let obej: ConfirmationScreen = ConfirmationScreen(nibName: "ConfirmationScreen", bundle: nil)
                self.navigationController?.pushViewController(obej, animated: true)
            }
            else
                
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
            
        }
        
    }
    @IBAction func actionTermAndConditions(_ sender: Any) {
        if isSelect == false{
            imgTerm_Conditions.image = UIImage.init(named: "selectdCheck")
            isSelect = true
            UserDefaults.standard.setValue("1", forKey: "TermsCondtions")
        } else {
            isSelect = false
            imgTerm_Conditions.image = UIImage.init(named: "unselectedCheckbox")
            UserDefaults.standard.setValue("0", forKey: "TermsCondtions")
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func actionback(_ sender: Any) {
        // SlideNavigationController.sharedInstance().toggleLeftMenu()
        if viewArabic.isHidden  == false {
            setRightToLeftViewTransition(true)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    // Method for manage view according to selected language
    func setViewAccodingToSelectedLanguage(lang: String) -> Void {
        if lang == "en" {
            viewEnglish.isHidden = false
            viewArabic.isHidden = true
        }else {
            viewEnglish.isHidden = true
            viewArabic.isHidden = false
        }
    }
    
    
    
}
