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
        viewDatePicker=UIView(frame: CGRect(x: 0, y: 0 , width: Constant.ScreenSize.SCREEN_WIDTH, height: 200))
        view.addSubview(viewDatePicker);
        viewDatePicker.isUserInteractionEnabled = true
        
        let toolBar:UIView = UIView(frame: CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT-220 , width: Constant.ScreenSize.SCREEN_WIDTH, height: 40))
        toolBar.backgroundColor = UIColor.white
        viewDatePicker.addSubview(toolBar)
        
        let doneBtn:UIButton = UIButton(frame: CGRect(x: Constant.ScreenSize.SCREEN_WIDTH - 100, y: 0 , width: 100 , height: 40))
        doneBtn.addTarget(self, action: #selector(tapDone), for: UIControlEvents.touchUpInside)
        toolBar .addSubview(doneBtn)
        doneBtn.setTitle("   Done", for: UIControlState.normal)
        doneBtn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: UIControlState.normal)
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.frame = CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT - 180, width: Constant.ScreenSize.SCREEN_WIDTH, height: 220)
        datePickerView.backgroundColor = UIColor.lightGray
        datePickerView.datePickerMode = UIDatePickerMode.date
        // dateTextField.inputView = datePickerView
        viewDatePicker.addSubview(datePickerView);
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)

        UIView.animate(withDuration: 0.2)
        {
            self.viewDatePicker.frame = CGRect(x: 0, y: 0, width: Constant.ScreenSize.SCREEN_WIDTH, height: 200)
        }
        
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
