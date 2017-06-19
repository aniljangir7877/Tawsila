//
//  ConfirmationScreen.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/19/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class ConfirmationScreen: UIViewController, UITextFieldDelegate {

    @IBOutlet var actionBack: UIButton!
    @IBOutlet var btnContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var txtVerificationCode: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        actionBack.addTarget(self, action: #selector(actionBackButton(_:)), for: UIControlEvents.touchUpInside)
        btnContinue.layer.cornerRadius = 4.0
        btnContinue.layer.masksToBounds = true
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

    
    //MARK:- UIButton's Action 
    @IBAction func actionContinue(_ sender: Any) {
    }
    
    @IBAction func actionDidNotGetCode(_ sender: Any) {
    }
    @IBAction func actionResendCode(_ sender: Any) {
    }
    
    //MARK: -UITextField Delegate Method implemnet
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }


}

