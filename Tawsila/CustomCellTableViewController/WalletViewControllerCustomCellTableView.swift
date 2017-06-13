//
//  WalletViewControllerCustomCellTableView.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class WalletViewControllerCustomCellTableView: UITableViewCell
{
    
    @IBOutlet weak var imageIconPaymentLeft: UIImageView!
    
    @IBOutlet weak var imageIconPaymentRight: UIImageView!
    
    
    @IBOutlet weak var lblTitleCash: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
