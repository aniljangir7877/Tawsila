//
//  forgotPassword.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/17/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class forgotPassword: UIViewController, UITextFieldDelegate {

    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSendNewPassword(_ sender: Any) {
        
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
        if (Utility.sharedInstance.trim(textField.text!)).characters.count == 0 {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter your email.", controller: self)
            return
        }
        
        if (AppDelegateVariable.appDelegate.isValidEmail(textField.text!) == false)
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Please enter valid email.", controller: self)
            return
        }
        
    }
    

}
