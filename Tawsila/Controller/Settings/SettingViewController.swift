//
//  SettingViewController.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/13/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var actionSignOut: UIButton!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var viewbackground: UIView!
    @IBOutlet weak var viewButtons: UIView!
    @IBOutlet weak var imgEng: UIImageView!
    @IBOutlet weak var imgArbic: UIImageView!
    var singleTap: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        actionSignOut.layer.cornerRadius = 4.0
        actionSignOut.layer.masksToBounds = true
        viewButtons.layer.cornerRadius = 4.0
        viewButtons.layer.masksToBounds = true
        viewbackground.isHidden = true
        UIView.animate(withDuration: 0.6, animations: {
            self.viewbackground.frame = CGRect(x: self.view.frame.size.width, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)
        singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapGestureHandler(gesture:)))
        singleTap.numberOfTapsRequired = 1
        viewbackground.addGestureRecognizer(singleTap)
        
        imgEng.image = UIImage.init(named: "circle")
        imgArbic.image = UIImage.init(named: "circle")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UIButton's Action 
    
    @IBAction func actionArabicSelect(_ sender: Any) {
        imgArbic.image = UIImage.init(named: "pinkSelectedRadio")
        imgEng.image = UIImage.init(named: "circle")
        UserDefaults.standard.setValue("Ar", forKey: "LanguageSelected")
        showAlert()
    }
    @IBAction func actionEnglishSelect(_ sender: Any) {
        imgEng.image = UIImage.init(named: "pinkSelectedRadio")
        imgArbic.image = UIImage.init(named: "circle")
         UserDefaults.standard.setValue("En", forKey: "LanguageSelected")
        showAlert()
    }
    @IBAction func actionLeftMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    @IBAction func actionChangePassword(_ sender: Any) {
        let obj: ChangePasswordViewController = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionPriceCard(_ sender: Any) {
    }
    @IBAction func actionLanguageChange(_ sender: Any) {
        viewbackground.isHidden = false
        UIView.animate(withDuration: 0.6, animations: {
            self.viewbackground.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)

    }
    
    @IBAction func actionRateAndReview(_ sender: Any) {
    }
    @IBAction func actionFeedback(_ sender: Any) {
    }

    @IBAction func actionSignOut(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let actionOK = UIAlertAction.init(title: "OK", style: .default) { (alert: UIAlertAction!) in
             let obj : SignInOrCreateNewAccount = SignInOrCreateNewAccount(nibName: "SignInOrCreateNewAccount", bundle: nil)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.navContorller = SlideNavigationController.init(rootViewController: obj)
            appDelegate.window?.rootViewController = appDelegate.navContorller
            appDelegate.window?.makeKeyAndVisible()
        }
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionTermAndCondition(_ sender: Any) {
    }
    
    //MARK:- UIAlertController
    func showAlert(){
        let alert = UIAlertController.init(title: "Tawsila", message: "This requires restarting the application. Are you sure you want to close the app now?", preferredStyle: .alert)
        let actionOK = UIAlertAction.init(title: "OK", style: .default) { (alert: UIAlertAction!) in
           // exit(0)
            // get a reference to the app delegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // call didFinishLaunchWithOptions ... why?
            appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)        }
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tapGestureHandler(gesture: UIGestureRecognizer) {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.viewbackground.frame = CGRect(x: self.view.frame.size.width, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion:{ _ in
            self.viewbackground.isHidden = true
        })

    }
}
