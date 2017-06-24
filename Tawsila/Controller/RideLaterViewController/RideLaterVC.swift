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
import RappleProgressHUD

class RideLaterVC: UIViewController ,GMSMapViewDelegate , GMSAutocompleteViewControllerDelegate
{
    @IBOutlet var viewArabic: UIView!
    @IBOutlet var viewEnglish: UIView!
    var viewDatePicker : UIView!
    var acController = GMSAutocompleteViewController()
    var temp : Int!
    var pickUpAddress = String ()
    
    @IBOutlet var pickDate: UITextField!
    @IBOutlet var pickTime: UITextField!
    @IBOutlet var imgLocation: UIImageView!
    @IBOutlet var imgDest: UIImageView!
    @IBOutlet var btnSchduleRide: UIButton!
    @IBOutlet var lblDestination: UILabel!
    @IBOutlet var lblLocatoin: UILabel!
    
    @IBOutlet var pickDateAr: UITextField!
    @IBOutlet var pickTimeAr: UITextField!
    @IBOutlet var imgLocationAr: UIImageView!
    @IBOutlet var imgDestAr: UIImageView!
    @IBOutlet var btnSchduleRideAr: UIButton!
    @IBOutlet var lblDestinationAr: UILabel!
    @IBOutlet var lblLocatoinAr: UILabel!
    
 
    
    var pickUpCordinate : CLLocationCoordinate2D!
    var destinationCordinate : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setShowAndHideViews(viewEnglish, vArb: viewArabic)
        setUpViews()
    }
    
    func setUpViews(){
        if AppDelegateVariable.appDelegate.strLanguage == "en"{
            imgDest.tintColor = UIColor.red
            imgDest.image = imgDest.image?.withRenderingMode(.alwaysTemplate)
            
            imgLocation.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            imgLocation.image = imgDest.image?.withRenderingMode(.alwaysTemplate)
            
            btnSchduleRide.layer.cornerRadius = 3;
            
            lblLocatoin.text = pickUpAddress
        }else{
            imgDestAr.tintColor = UIColor.red
            imgDestAr.image = imgDestAr.image?.withRenderingMode(.alwaysTemplate)
            
            imgLocationAr.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            imgLocationAr.image = imgDestAr.image?.withRenderingMode(.alwaysTemplate)
            
            btnSchduleRideAr.layer.cornerRadius = 3;
            
            lblLocatoinAr.text = pickUpAddress
        }
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
            if AppDelegateVariable.appDelegate.strLanguage == "en" {
                pickTime.inputView = datePickerView
                pickTime.inputAccessoryView = toolBar
                pickTime .becomeFirstResponder()
                datePickerView.datePickerMode = UIDatePickerMode.time
                temp = 0;
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH : mm"
                pickTime.text = dateFormatter.string(from:NSDate() as Date)
            }else{
                pickTimeAr.inputView = datePickerView
                pickTimeAr.inputAccessoryView = toolBar
                pickTimeAr.becomeFirstResponder()
                datePickerView.datePickerMode = UIDatePickerMode.time
                temp = 0;
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH : mm"
                pickTimeAr.text = dateFormatter.string(from:NSDate() as Date)
            }
           
            
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if AppDelegateVariable.appDelegate.strLanguage == "en" {
                pickDate.text = dateFormatter.string(from:NSDate() as Date)
                
                pickDate.inputView = datePickerView
                pickDate.inputAccessoryView = toolBar
                pickDate .becomeFirstResponder()
            }
            else{
                pickDateAr.text = dateFormatter.string(from:NSDate() as Date)
                
                pickDateAr.inputView = datePickerView
                pickDateAr.inputAccessoryView = toolBar
                pickDateAr.becomeFirstResponder()
            }
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
            if AppDelegateVariable.appDelegate.strLanguage == "en" {
                 pickDate.text = dateFormatter.string(from:sender.date as Date)
            }else{
                 pickDateAr.text = dateFormatter.string(from:sender.date as Date)
            }
           
            
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH : MM"
            if AppDelegateVariable.appDelegate.strLanguage == "en" {
                 pickTime.text = dateFormatter.string(from:sender.date as Date)
            }
            else{
             pickTimeAr.text = dateFormatter.string(from:sender.date as Date)
            }
           
        }
        
        
        
        // dateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func donePicker()
    {
        if AppDelegateVariable.appDelegate.strLanguage == "en"{
        pickDate.resignFirstResponder()
        pickTime.resignFirstResponder()
        }
        else{
            pickDateAr.resignFirstResponder()
            pickTimeAr.resignFirstResponder()
        }
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
        acController.delegate = self
        
    }
    
    @IBAction func tapDestination(_ sender: Any) {
        
        
        
      //  "username => Mandatory, purpose => Mandatory [PTPT,AT,HR,OT], pickup_area => Mandatory, pickup_date => Mandatory, drop_area => Mandatory, pickup_time => Mandatory, area, landmark,
      //  pickup_address => Mandatory, taxi_type => Mandatory, departure_time, departure_date, return_date, flight_number, package, promo_code, distance => Mandatory, amount => Mandatory, address, transfer, payment_media => Mandatory, km, timetype, lat => Mandatory, long => Mandatory, random => 78945662, device_id=> Mandatory
        
        
        let random : String = "24324323"
        
        let dic = NSMutableDictionary()
        
        dic.setValue("scientificwebs", forKey: "username")
        dic.setValue("PTPT", forKey: "purpose")
        if AppDelegateVariable.appDelegate.strLanguage == "en" {
            dic.setValue(lblLocatoin.text, forKey: "pickup_area")
            dic.setValue(pickDate.text, forKey: "pickup_date")
            dic.setValue(pickTime.text, forKey: "pickup_time")
            dic.setValue(lblDestination.text, forKey: "drop_area")
             dic.setValue(lblLocatoin.text, forKey: "pickup_address")
        }else{
            dic.setValue(lblLocatoinAr.text, forKey: "pickup_area")
            dic.setValue(pickDateAr.text, forKey: "pickup_date")
            dic.setValue(pickTimeAr.text, forKey: "pickup_time")
            dic.setValue(lblDestinationAr.text, forKey: "drop_area")
            dic.setValue(lblLocatoinAr.text, forKey: "pickup_address")
        }
        
        dic.setValue("", forKey: "area")
        dic.setValue("", forKey: "landmark")
       
        dic.setValue("sedan", forKey: "taxi_type")
        dic.setValue("", forKey: "departure_time")
        dic.setValue("", forKey: "departure_date")
        dic.setValue("", forKey: "flight_number")
        dic.setValue("", forKey: "package")
        dic.setValue("", forKey: "promo_code")
        dic.setValue("15", forKey: "distance")
        dic.setValue("150", forKey: "amount")
        dic.setValue("jaipur", forKey: "address")
        dic.setValue("", forKey: "transfer")
        dic.setValue("cash", forKey: "payment_media")
        dic.setValue("15", forKey: "km")
        dic.setValue("", forKey: "timetype")
        dic.setValue(String (format: "%f", pickUpCordinate.latitude), forKey: "lat")
        dic.setValue(String (format: "%f", destinationCordinate.longitude), forKey: "long")
        dic.setValue(random, forKey: "random")
        dic.setValue("2341234234345234", forKey: "device_id")
        
        // let str = "http://taxiappsourcecode.com/api/index.php?option=booking_request"
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        let parameterString = String(format : "index.php?option=booking_request")
        
        Utility.sharedInstance.postDataInJson(header: parameterString,  withParameter:dic ,inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                var userDict = (dataDictionary.object(forKey: "result") as! NSDictionary).mutableCopy() as! NSMutableDictionary
                userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict)
                
                USER_DEFAULT.set("1", forKey: "isLogin")
                USER_DEFAULT.set(userDict, forKey: "userData")
                
                
                //print("Location:  \(userInfo)")
                /// NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: (userInfo as AnyObject) as? [AnyHashable : Any])
                // AppDelegateVariable.appDelegate.loginInMainView()
            }
            else
                
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
            
        }

        
    }
    
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

// MARK:
// MARK: - GMSAutocomplete Delegate

//extension ViewController: GMSAutocompleteViewControllerDelegate {
//    
//    // Handle the user's selection.
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
//    {
//        print("Place name: \(place.name)")
//        // print("Place address: \(place.formattedAddress)")
//        // print("Place attributions: \(place.attributions)")
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//    
//    // User canceled the operation.
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//    
//    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//    
//}

