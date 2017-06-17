//
//  SignInOrCreateNewAccount.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 10/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class SignInOrCreateNewAccount: UIViewController {
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var btnCreateNewAccount: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        AppDelegateVariable.appDelegate.checkNewVerisonAvailabel(viewController: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = NavigationBackgraoungColor
        
        btnSignIn.layer.cornerRadius = 4.0
        btnSignIn.layer.masksToBounds = true
    }
    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionSignIn(_ sender: Any) {
        let obj : SignInViewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
        navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionCreateNewAccout(_ sender: Any) {
        let obj : CreateNewAccount = CreateNewAccount(nibName: "CreateNewAccount", bundle: nil)
        navigationController?.pushViewController(obj, animated: true)
    }
}
