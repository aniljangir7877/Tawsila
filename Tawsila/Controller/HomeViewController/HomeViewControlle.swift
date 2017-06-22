//
//  HomeViewControlle.swift
//  Tawsila
//
//  Created by Sanjay on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RappleProgressHUD
import Alamofire


class HomeViewControlle: UIViewController ,GMSMapViewDelegate ,SlideNavigationControllerDelegate ,GMSAutocompleteViewControllerDelegate   {
    
    var mapView: GMSMapView!
    @IBOutlet var viewForMap: UIView!
    
    @IBOutlet var lblPickAddress: UILabel!
    @IBOutlet var viewPickAddress: UIView!
    @IBOutlet var viewDestinationAddress: UIView!
    @IBOutlet var lblDestinationAddress: UILabel!
    
    @IBOutlet var imageDestDot: UIImageView!
    @IBOutlet var imagePicDot: UIImageView!
    
    @IBOutlet var buttonConfirmBooking: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewConfirmBtns: UIView!
    
    var acController = GMSAutocompleteViewController()
    var locationManager = CLLocationManager()
    
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var scrollViewCars: UIScrollView!
    
    @IBOutlet var viewEstimate: UIView!
    
    @IBOutlet var imgMidPin: UIImageView!
    var pickUpCordinate : CLLocationCoordinate2D!
    var destinationCordinate : CLLocationCoordinate2D!
    var tagBookNow : Int!
    
    var arrCars : NSArray!

    @IBOutlet var lblEstimatedTime: UILabel!
    @IBOutlet var lblEstimatedFare: UILabel!
    
    var rightBarButton : UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tagBookNow = 0
        // Border View Address
        let leftMenu: LeftMenuViewController = LeftMenuViewController(nibName: "LeftMenuViewController", bundle: nil)
        
        let rightMenu: rightMenuViewController = rightMenuViewController(nibName: "rightMenuViewController", bundle: nil)
        
        SlideNavigationController.sharedInstance().leftMenu = leftMenu
        SlideNavigationController.sharedInstance().rightMenu = rightMenu
        
        // Border View Address
        
        viewPickAddress.layer.borderColor = UIColor.lightGray.cgColor
        viewPickAddress.layer.borderWidth = 1
        
        viewDestinationAddress.layer.borderColor = UIColor.lightGray.cgColor
        viewDestinationAddress.layer.borderWidth = 1
        viewDestinationAddress.isHidden = true
        
        buttonConfirmBooking.layer.cornerRadius = 3
        btnCancel.layer.cornerRadius = 3

        viewEstimate.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        viewEstimate.layer.borderWidth = 0.5
        viewEstimate.layer.cornerRadius = 3
        viewEstimate.isHidden = true
        
        // -- Locaton Manager
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self .perform( #selector(self.updateLocation), with: 1, afterDelay: 0)
        

        // MARK: - Load Cars API
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
       
        viewBottom.isHidden = true
        viewConfirmBtns.isHidden = true
        
        let string:String = String (format: "http://taxiappsourcecode.com/api/index.php?option=get_cars")
        
        Alamofire.request(string, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            let array : NSArray = ((response.result.value as AnyObject).object(forKey:"result") as! NSArray)
            self.arrCars = array
            self.loadCars(arrayCars: array)
            
            RappleActivityIndicatorView.stopAnimation()

        }
    }
    
    // MARK:
    // MARK: - Bottom View
    
    func loadCars(arrayCars: Any)
    {
        let wd = 80
        
        for i in 0 ... (self.arrCars.count - 1) {
            
            let dict : NSDictionary = self.arrCars .object(at: i) as! NSDictionary
            
            
            let lblTime = UILabel(frame: CGRect(x: i * wd, y: 0, width: wd, height: 25))
            lblTime.textAlignment = .center
            lblTime.text = "10 min"
            lblTime.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            lblTime.font = UIFont .systemFont(ofSize: 13)
            self.scrollViewCars.addSubview(lblTime)
            
            if i < (self.arrCars.count - 1)
            {
                let lbl_line = UILabel(frame: CGRect(x: wd + i * wd, y: 20, width: 1, height: 50))
                lbl_line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.scrollViewCars.addSubview(lbl_line)
            }
            
            //            let imgUrl = dict.object(forKey: "car_type") as? String
            
            let car_icon = UIImageView(frame: CGRect(x: wd/2 - 30 + i * wd, y: 25, width: 60, height: 40))
            car_icon.image = #imageLiteral(resourceName: "carIcon")
            self.scrollViewCars.addSubview(car_icon)
            car_icon.contentMode = UIViewContentMode.scaleAspectFit
            
            let lblCarName = UILabel(frame: CGRect(x: i * wd, y:65, width: wd, height: 21))
            lblCarName.textAlignment = .center
            lblCarName.text = dict.object(forKey: "car_type") as? String
            lblCarName.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            lblCarName.font = UIFont .systemFont(ofSize: 13)
            self.scrollViewCars.addSubview(lblCarName)
            
            let btnTapCar = UIButton(frame: CGRect(x: i * wd, y: 0, width: wd, height: 90))
            self.scrollViewCars.addSubview(btnTapCar)
            btnTapCar .addTarget(self, action: #selector(tapCarBottom), for: UIControlEvents.touchUpInside)
            btnTapCar.tag = i
        }
        scrollViewCars.showsHorizontalScrollIndicator = false
        scrollViewCars .contentSize = CGSize(width: 6*wd, height: 90)
        viewBottom.isHidden = false
    }
    
    
    func tapCarBottom(sender:UIButton)  {
        
        let popUp : ViewDetailCar = Bundle.main.loadNibNamed("ViewDetailCar", owner: 0, options: nil)![0] as? UIView as! ViewDetailCar
        popUp.cat_type.text = (self.arrCars.object(at: sender.tag) as! NSDictionary) .object(forKey: "car_type") as? String
        popUp.frame = self.view.frame
        self.view.addSubview(popUp)
    }
    
    // MARK: SlideNavigationController Delegate
    @IBAction func actionLeftMenu(_ sender: Any) {
        //        [[SlideNavigationController sharedInstance] toggleLeftMenu]
        
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    //slidernavigationController delegate
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
    
    func slideNavigationControllerShouldDisplayRightMenu() -> Bool {
        return false
    }
    // MARK: - Bottom Buttons Methods
    
    
    @IBAction func tapBookNow(_ sender: Any) {
        
        tagBookNow = 1;
        imagePicDot.image = #imageLiteral(resourceName: "dotGreen")
        imageDestDot.tintColor = UIColor.red
        imageDestDot.image = imageDestDot.image?.withRenderingMode(.alwaysTemplate)
        
        viewDestinationAddress.isHidden = false
        self.viewConfirmBtns.isHidden = false
        
        destinationCordinate = pickUpCordinate
        
        UIView.animate(withDuration: 0.2)
        {
            self.viewBottom.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
        }
        

    }
    
    @IBAction func tapCacelBooking(_ sender: Any)
    {
        viewDestinationAddress.isHidden = true
        tagBookNow = 0;
        imagePicDot.image = #imageLiteral(resourceName: "Search")
        mapView.clear()
        imgMidPin.isHidden = false

        UIView.animate(withDuration: 0.2)
        {
            self.viewBottom.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT-134  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
        }

    }
    
//}
    
//    @IBAction func tapCacelBooking(_ sender: Any)
//    {
//        viewDestinationAddress.isHidden = true
//        tagBookNow = 0;
//        imagePicDot.image = #imageLiteral(resourceName: "Search")
//        mapView.clear()
//        imgMidPin.isHidden = false
//
//        UIView.animate(withDuration: 0.2)
//        {
//            self.viewBottom.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT-134  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
//        }
//
//        mapView.animate(toZoom: 10)
//
//    }
//    

    
    @IBAction func tapRideLater(_ sender: Any) {
        
        let obj : RideLaterVC = RideLaterVC(nibName: "RideLaterVC", bundle: nil)
        obj.pickUpAddress = lblPickAddress.text!
        navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    // MARK:
    // MARK: - MapView Delegate
    
    func updateLocation()
    {
        let lat =    locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self as GMSMapViewDelegate
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
        mapView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenSize.SCREEN_WIDTH, height: Constant.ScreenSize.SCREEN_HEIGHT)
        viewForMap.addSubview(mapView)
    }
    
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        if self.tagBookNow == 1
        {
            destinationCordinate = position.target
        }
        if self.tagBookNow == 0
        {
            pickUpCordinate = position.target
        }
        
        
        let string:String = String (format: "http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&language=ENGLISH", position.target.latitude,position.target.longitude)
        
        print(string)
        
        Alamofire.request(string, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            print(response);
            
            do
            {
                if (response.result.value != nil)
                {
                    let array : NSArray = ((response.result.value as AnyObject).object(forKey:"results") as! NSArray)
                    
                    if (array.count > 0)
                    {
                        let dic = array.object(at: 0) as! NSDictionary
                        let addressString = dic .object(forKey: "formatted_address") as! String
                        
                        if self.tagBookNow == 0
                        {
                            self.lblPickAddress.text = addressString
                        }
                        if self.tagBookNow == 1
                        {
                            self.lblDestinationAddress.text = addressString
                        }
                    }
                }
                else
                {
                    self.lblPickAddress.text = "location not found"
                }
            }catch{
                print("error")
            }
            
        }
        
        
    }
    
    @IBAction func tapConfirmBooking(_ sender: Any)
    {
        
        if self.tagBookNow == 1 {
            
            viewEstimate.isHidden = false
            imgMidPin.isHidden = true
            
            let marker_pick = GMSMarker()
            marker_pick.position = pickUpCordinate
            marker_pick.title = lblPickAddress.text
            marker_pick.map = mapView
            marker_pick.icon = #imageLiteral(resourceName: "markerLocation")
            
            let marker_dest = GMSMarker()
            marker_dest.position = destinationCordinate
            marker_dest.title = lblPickAddress.text
            marker_dest.map = mapView
            marker_dest.icon = #imageLiteral(resourceName: "markerDesitnation")
            
            getPolylineRoute(from: pickUpCordinate, to: destinationCordinate)
            
            self.tagBookNow = 2
        }
        else
        {
            // "username => Mandatory, purpose => Mandatory [PTPT,AT,HR,OT], pickup_area => Mandatory, pickup_date => Mandatory, drop_area => Mandatory, pickup_time => Mandatory, area, landmark,
            // pickup_address => Mandatory, taxi_type => Mandatory, departure_time, departure_date, return_date, flight_number, package, promo_code, distance => Mandatory, amount => Mandatory, address, transfer, payment_media => Mandatory, km, timetype, lat => Mandatory, long => Mandatory, random => 78945662, device_id=> Mandatory
            
//<<<<<<< HEAD
//            
//=======
            let random : String = "24324323"
//>>>>>>> a13e96c6d8c53c14144ab82d6a026b09a1d35d23
            
            let dic = NSMutableDictionary()
            
            dic.setValue("scientificwebs", forKey: "username")
            dic.setValue("PTPT", forKey: "purpose")
////<<<<<<< HEAD
//            dic.setValue("Jaipur", forKey: "pickup_area")
//            dic.setValue("21/06/2017", forKey: "pickup_date")
//            dic.setValue("05:05 am", forKey: "pickup_time")
//            dic.setValue("Jaipur", forKey: "drop_area")
//            dic.setValue("jaipur", forKey: "area")
//            dic.setValue("", forKey: "landmark")
//            dic.setValue("jaipur", forKey: "pickup_address")
//=======
            dic.setValue(lblPickAddress.text, forKey: "pickup_area")
            dic.setValue("21/06/2017", forKey: "pickup_date")
            dic.setValue("05:05 am", forKey: "pickup_time")
            dic.setValue(lblDestinationAddress.text, forKey: "drop_area")
            dic.setValue("", forKey: "area")
            dic.setValue("", forKey: "landmark")
            dic.setValue(lblPickAddress.text, forKey: "pickup_address")
//>>>>>>> a13e96c6d8c53c14144ab82d6a026b09a1d35d23
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
//<<<<<<< HEAD
//            dic.setValue("26.000", forKey: "lat")
//            dic.setValue("75.66", forKey: "long")
//            dic.setValue("234234234", forKey: "random")
//=======
            dic.setValue(String (format: "%f", pickUpCordinate.latitude), forKey: "lat")
            dic.setValue(String (format: "%f", destinationCordinate.longitude), forKey: "long")
            dic.setValue(random, forKey: "random")
//>>>>>>> a13e96c6d8c53c14144ab82d6a026b09a1d35d23
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
    }

    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        Alamofire.request(url.absoluteString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            print(response);
            
            do {
                
                if (response.result.value != nil)
                {
                    
                    let routes = (response.result.value as AnyObject).object(forKey: "routes")  as? [Any]
                    
                    
                    let overview_polyline : NSDictionary = (routes?[0] as? NSDictionary)!
                    
                    let dic : NSDictionary = overview_polyline as Any as! NSDictionary
                    
                    let value : NSDictionary = dic.object(forKey: "overview_polyline") as! NSDictionary
                    
                    let polyString : String = value.object(forKey: "points") as! String
                    
                    self.showPath(polyStr: polyString)
                    
                    let estTime =  (((((dic.object(forKey: "legs") as! NSArray) .object(at: 0) ) as AnyObject)
                        .object(forKey: "duration") ) as! NSDictionary) .object(forKey: "text") as? String
                    
                    let estDistance : String =  ((((((dic.object(forKey: "legs") as! NSArray) .object(at: 0) ) as AnyObject)
                        .object(forKey: "distance") ) as! NSDictionary) .object(forKey: "text") as? String)!
                    
                    let doubleValue : Double = NSString(string: estDistance).doubleValue // 3.1
                    
                    self.lblEstimatedFare.text =  String (format: "%.1f SAR", doubleValue*10)
                    self.lblEstimatedTime.text = estTime
                    
                }
                
            }catch{
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
        
        // Today
        
        var bounds = GMSCoordinateBounds()
        
        for index in 1...Int((path?.count())!)
            
        {
            bounds = bounds.includingCoordinate((path?.coordinate(at: UInt(index)))!)
        }
        
        bounds = bounds.includingCoordinate(pickUpCordinate)
        bounds = bounds.includingCoordinate(destinationCordinate)
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100))
        self.tagBookNow = 2
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK:
    // MARK: - Tap Search
    
    @IBAction func tapSearch(_ sender: Any) {
        
                acController = GMSAutocompleteViewController()
                acController.delegate = self
                present(acController, animated: true, completion: nil)
        
    }
    
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
        {
            //print("Place name: \(place.name)")
            // print("Place address: \(place.formattedAddress)")
            // print("Place attributions: \(place.attributions)")
            dismiss(animated: true, completion: nil)
            let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 10.0)
            mapView.camera = camera

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

