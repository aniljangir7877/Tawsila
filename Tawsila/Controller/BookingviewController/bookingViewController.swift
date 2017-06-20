//
//  bookingViewController.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/15/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class bookingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var btbBack: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        btbBack.addTarget(self, action: #selector(actionBackButton(_:)), for: .touchUpInside)
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

}
