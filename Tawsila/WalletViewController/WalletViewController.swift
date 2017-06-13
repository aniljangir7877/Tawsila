//
//  WalletViewController.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{

    var headerTitlesPayments : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        headerTitlesPayments = ["Cash", "Add credit card"]

        let nib = UINib(nibName: "WalletViewControllerCustomCellTableView", bundle: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.headerTitlesPayments.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "WalletViewControllerCustomCellTableView"
        var cell: WalletViewControllerCustomCellTableView! = tableView.dequeueReusableCell(withIdentifier: identifier) as? WalletViewControllerCustomCellTableView
        if cell == nil
        {
            tableView.register(UINib(nibName: "WalletViewControllerCustomCellTableView", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? WalletViewControllerCustomCellTableView
        }
        cell.lblTitleCash.text = headerTitlesPayments.object(at: indexPath.row) as? String
        cell.selectionStyle = .none
        return cell
    }

}
