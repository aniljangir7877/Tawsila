//
//  RideLaterVC.swift
//  Tawsila
//
//  Created by Sanjay on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit


class RideLaterVC: UIViewController {
    
    var viewDatePicker : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapPickDate(_ sender: Any)
    {
               
    }
    
    func tapDone(){
        
        UIView.animate(withDuration: 0.2) {
            
            self.viewDatePicker.frame = CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT, width: Constant.ScreenSize.SCREEN_WIDTH, height: 200)
        }

    }
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    
    @IBAction func tapPickTime(_ sender: Any) {
    }
    
    @IBAction func tapLocation(_ sender: Any) {
    }
    
    @IBAction func tapDestination(_ sender: Any) {
        
    }
}
