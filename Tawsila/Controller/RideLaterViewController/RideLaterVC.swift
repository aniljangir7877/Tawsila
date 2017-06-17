//
//  RideLaterVC.swift
//  Tawsila
//
//  Created by Sanjay on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire


class RideLaterVC: UIViewController ,GMSMapViewDelegate
{
    
    var viewDatePicker : UIView!
    
    @IBOutlet var pickDate: UITextField!
    @IBOutlet var pickTime: UITextField!
    
    var acController = GMSAutocompleteViewController()
    
    var temp : Int!
    
    @IBOutlet var imgLocation: UIImageView!
    @IBOutlet var imgDest: UIImageView!
    @IBOutlet var btnSchduleRide: UIButton!
    
    var pickUpAddress = String ()
    
    @IBOutlet var lblDestination: UILabel!
    @IBOutlet var lblLocatoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgDest.tintColor = UIColor.red
        imgDest.image = imgDest.image?.withRenderingMode(.alwaysTemplate)
        
        imgLocation.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        imgLocation.image = imgDest.image?.withRenderingMode(.alwaysTemplate)
        
        btnSchduleRide.layer.cornerRadius = 3;
        
        lblLocatoin.text = pickUpAddress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapPickDate(_ sender: UIButton)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = THEME_COLOR
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RideLaterVC.donePicker))
        
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RideLaterVC.donePicker))
        
        
        
        toolBar.setItems([cancelButton, spaceButton ,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        if sender.tag == 1
        {
            pickTime.inputView = datePickerView
            pickTime.inputAccessoryView = toolBar
            pickTime .becomeFirstResponder()
            datePickerView.datePickerMode = UIDatePickerMode.time
            temp = 0;
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH : mm"
            pickTime.text = dateFormatter.string(from:NSDate() as Date)
            
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            pickDate.text = dateFormatter.string(from:NSDate() as Date)
            
            pickDate.inputView = datePickerView
            pickDate.inputAccessoryView = toolBar
            pickDate .becomeFirstResponder()
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            temp = 1;
        }
        
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        if temp == 1
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/mm/yyyy"
            pickDate.text = dateFormatter.string(from:sender.date as Date)
            
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH : MM"
            pickTime.text = dateFormatter.string(from:sender.date as Date)
        }
        
        
        
        // dateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func donePicker()
    {
        pickDate.resignFirstResponder()
        pickTime.resignFirstResponder()
    }
    
    func tapDone(){
        
        UIView.animate(withDuration: 0.2) {
            
            self.viewDatePicker.frame = CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT, width: Constant.ScreenSize.SCREEN_WIDTH, height: 200)
        }
        
    }
    
    
    
    
    @IBAction func tapPickTime(_ sender: Any) {
    }
    
    @IBAction func tapLocation(_ sender: Any) {
        
        acController = GMSAutocompleteViewController()
        present(acController, animated: true, completion: nil)
        acController.delegate = self as? GMSAutocompleteViewControllerDelegate
        
    }
    
    @IBAction func tapDestination(_ sender: Any) {
        
    }
}

// MARK:
// MARK: - GMSAutocomplete Delegate

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        print("Place name: \(place.name)")
        // print("Place address: \(place.formattedAddress)")
        // print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

