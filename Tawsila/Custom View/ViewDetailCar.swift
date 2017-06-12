//
//  ViewDetailCar.swift
//  Tawsila
//
//  Created by Sanjay on 12/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class ViewDetailCar: UIView {

   
    @IBOutlet var viewMid: UIView!
    
    override func draw(_ rect: CGRect) {
   
        viewMid.layer.cornerRadius = 5;
    }
   
    @IBAction func tapCross(_ sender: Any) {
        
        self.removeFromSuperview()
    }

}
