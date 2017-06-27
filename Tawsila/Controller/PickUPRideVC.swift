//
//  PickUPRideVC.swift
//  Tawsila
//
//  Created by Sanjay on 21/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import GoogleMaps
import RappleProgressHUD
import RappleProgressHUD
import Alamofire
import SDWebImage

class PickUPRideVC: UIViewController , GMSMapViewDelegate , notificationDelegate  {
    
    
    
    var mapView: GMSMapView!
    
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var viewForMap: UIView!
    
    var cordinatePick = CLLocationCoordinate2D()
    var cordinateDrop = CLLocationCoordinate2D()
    var cordinateDestination = CLLocationCoordinate2D()
    
    var cordinateDriver = CLLocationCoordinate2D()
    
    
    var id_booking : String!
    var id_driver : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lblTime.layer.cornerRadius = 15;
        lblTime.clipsToBounds = true
        lblTime.layer.borderWidth = 0.8
        lblTime.layer.borderColor = UIColor.white.cgColor
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.00, longitude: 75.00, zoom: 10.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self as GMSMapViewDelegate
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
        mapView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenSize.SCREEN_WIDTH, height: Constant.ScreenSize.SCREEN_HEIGHT)
        viewForMap.addSubview(mapView)
        
        cordinatePick = CLLocationCoordinate2DMake(25.00, 75.00)
        
        let marker_pick = GMSMarker()
        marker_pick.position = cordinatePick
        marker_pick.map = mapView
        marker_pick.icon = #imageLiteral(resourceName: "markerLocation")
        
        for i in 100 ... 104
        {
            let img: UIImageView = self.view .viewWithTag(i) as! UIImageView
            img.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            img.image = img.image?.withRenderingMode(.alwaysTemplate)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Fotter Methods
    
    @IBAction func tapCall(_ sender: Any) {
        
        let number = URL(string: "tel://1234" )
        UIApplication.shared.open(number!)
        
    }
    
    @IBAction func tapCancelRide(_ sender: Any){
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Cancel Ride", message: "Sure Want to Cacel Ride", preferredStyle: .alert)
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            
            
            
        }
        
        let noAction: UIAlertAction = UIAlertAction(title: "No", style: .default) { action -> Void in
            
            
            
        }
        
        actionSheetController.addAction(noAction)
        actionSheetController.addAction(yesAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func tapShare(_ sender: Any) {
        
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func tapLiveCamera(_ sender: Any) {
        
    }
    
    @IBAction func tapMore(_ sender: Any) {
        
    }
    
    
    // MARK: - Perform APIs
    // MARK:
    
    func cancelRide()
    {
        
        
        let dic = NSMutableDictionary()
        
        dic .setValue("cancel", forKey: "reason_to_cancel")
        dic .setValue(AppDelegateVariable.appDelegate.id_booking, forKey: "booking_id")
        dic .setValue(USER_NAME, forKey: "rider_id")
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        
        var parameterString = String(format : "cancel_booking_by_rider")
        
        
        for (key, value) in dic
        {
            parameterString = String (format: "%@&%@=%@", parameterString,key as! CVarArg,value as! CVarArg)
            // println("\(key) -> \(value)")
        }
        
        // booking_id, rider_id=username, reason_to_cancel
        // http://taxiappsourcecode.com/api/index.php?option=
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Success", message: "Ride Successfully Cancel", preferredStyle: .alert)
                
                let yesAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                actionSheetController.addAction(yesAction)
                self.present(actionSheetController, animated: true, completion: nil)
                
            }
            else
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
        }
        
    }
    
    
    func getDriverDetail()
    {
        
        let dic = NSMutableDictionary()
        
        dic .setValue("driver", forKey: "usertype")
        dic .setValue(id_driver, forKey: "id")
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        var parameterString = String(format : "get_user_profile")
        
        for (key, value) in dic
        {
            parameterString = String (format: "%@&%@=%@", parameterString,key as! CVarArg,value as! CVarArg)
        }
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Success", message: "Ride Successfully Cancel", preferredStyle: .alert)
                
                let yesAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                actionSheetController.addAction(yesAction)
                self.present(actionSheetController, animated: true, completion: nil)
                
            }
            else
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
        }
    }
    
    func sendPushNotification(title:String, message:String, fcmID: String)
    {
        
        let dic = NSMutableDictionary()
        
        dic.setValue("driver", forKey: "device_id")
        dic.setValue(id_driver, forKey: "message")
        dic.setValue(id_driver, forKey: "Title")
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        var parameterString = String(format : "push_notification")
        
        for (key, value) in dic
        {
            parameterString = String (format: "%@&%@=%@", parameterString,key as! CVarArg,value as! CVarArg)
        }
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                
                let actionSheetController: UIAlertController = UIAlertController(title: "Success", message: "Ride Successfully Cancel", preferredStyle: .alert)
                
                let yesAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                actionSheetController.addAction(yesAction)
                self.present(actionSheetController, animated: true, completion: nil)
                
            }
            else
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
        }
    }
    
    
    // MARK: - Drow Route Method
    // MARK:
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        Alamofire.request(url.absoluteString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            // print(response);
            
            do {
                
                if (response.result.value != nil)
                {
                    
                    let routes = (response.result.value as AnyObject).object(forKey: "routes")  as? [Any]
                    
                    let overview_polyline : NSDictionary = (routes?[0] as? NSDictionary)!
                    
                    let dic : NSDictionary = overview_polyline as Any as! NSDictionary
                    
                    let value : NSDictionary = dic.object(forKey: "overview_polyline") as! NSDictionary
                    
                    let polyString : String = value.object(forKey: "points") as! String
                    
                    self.showPath(polyStr: polyString)
                    
                    //                    let estTime =  (((((dic.object(forKey: "legs") as! NSArray) .object(at: 0) ) as AnyObject)
                    //                        .object(forKey: "duration") ) as! NSDictionary) .object(forKey: "text") as? String
                    //
                    //                    let estDistance : String =  ((((((dic.object(forKey: "legs") as! NSArray) .object(at: 0) ) as AnyObject)
                    //                        .object(forKey: "distance") ) as! NSDictionary) .object(forKey: "text") as? String)!
                    //
                    //                    let doubleValue : Double = NSString(string: estDistance).doubleValue // 3.1
                    //
                    //                    self.lblEstimatedFare.text =  String (format: "%.1f SAR", doubleValue*10)
                    //                    self.lblEstimatedTime.text = estTime
                    
                }
                
            } catch
            {
                print("error in JSONSerialization")
            }
            
        }
    }
    
    func showPath(polyStr :String)
    {
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = #colorLiteral(red: 0.7661251426, green: 0.6599388719, blue: 0, alpha: 1)
        
        polyline.map = mapView
        
        var bounds = GMSCoordinateBounds()
        
        for index in 1...Int((path?.count())!)
            
        {
            bounds = bounds.includingCoordinate((path?.coordinate(at: UInt(index)))!)
        }
        bounds = bounds.includingCoordinate(cordinatePick)
        bounds = bounds.includingCoordinate(cordinateDrop)
        bounds = bounds.includingCoordinate(cordinateDriver)
        
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100))
        
    }
    
    func gotNotification(title: String) {
        if (title == "cancel_by_driver")
        {
            
        }
        
    }
    
    public static func getTopViewController() -> UIViewController?{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController
        {
            while (topController.presentedViewController != nil)
            {
                topController = topController.presentedViewController!
            }
            return topController
        }
        return nil
    }
    
}
