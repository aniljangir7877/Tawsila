//
//  MyRidesTableViewCell.swift
//  Tawsila
//
//  Created by vikram singh charan on 6/13/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class MyRidesTableViewCell: UITableViewCell {

    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblPrcie: UILabel!
    @IBOutlet var imgUserProfile: UIImageView!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblInitialAddress: UILabel!
    @IBOutlet var lblDestinationAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height/2
        imgUserProfile.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
