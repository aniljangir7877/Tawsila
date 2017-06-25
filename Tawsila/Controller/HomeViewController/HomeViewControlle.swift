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
    
    // IBOutlet for English View
    @IBOutlet var viewEnglish: UIView!
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
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var scrollViewCars: UIScrollView!
    @IBOutlet var viewEstimate: UIView!
    @IBOutlet var imgMidPin: UIImageView!
    @IBOutlet var lblEstimatedTime: UILabel!
    @IBOutlet var lblEstimatedFare: UILabel!
    // IBOutlet for Arabic View
    @IBOutlet var viewArabic: UIView!
    @IBOutlet var viewForMapAr: UIView!
    @IBOutlet var lblPickAddressAr: UILabel!
    @IBOutlet var viewPickAddressAr: UIView!
    @IBOutlet var viewDestinationAddressAr: UIView!
    @IBOutlet var lblDestinationAddressAr: UILabel!
    @IBOutlet var imageDestDotAr: UIImageView!
    @IBOutlet var imagePicDotAr: UIImageView!
    @IBOutlet var buttonConfirmBookingAr: UIButton!
    @IBOutlet var btnCancelAr: UIButton!
    @IBOutlet var viewConfirmBtnsAr: UIView!
    @IBOutlet var viewBottomAr: UIView!
    @IBOutlet var scrollViewCarsAr: UIScrollView!
    @IBOutlet var viewEstimateAr: UIView!
    @IBOutlet var imgMidPinAr: UIImageView!
    @IBOutlet var lblEstimatedTimeAr: UILabel!
    @IBOutlet var lblEstimatedFareAr: UILabel!
    
    var acController = GMSAutocompleteViewController()
    var locationManager = CLLocationManager()
    var rightBarButton : UIBarButtonItem!
    var pickUpCordinate : CLLocationCoordinate2D!
    var destinationCordinate : CLLocationCoordinate2D!
    var tagBookNow : Int!
    var arrCars : NSArray!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tagBookNow = 0
        // -- Locaton Manager
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self .perform( #selector(self.updateLocation), with: 1, afterDelay: 0)
        

        // MARK: - Load Cars API
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        if  AppDelegateVariable.appDelegate.strLanguage == "en" {
            viewBottom.isHidden = true
            viewConfirmBtns.isHidden = true
        }else{
            viewBottomAr.isHidden = true
            viewConfirmBtnsAr.isHidden = true
        }
      
        let string:String = String (format: "http://taxiappsourcecode.com/api/index.php?option=get_cars")
        
        Alamofire.request(string, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            let array : NSArray = ((response.result.value as AnyObject).object(forKey:"result") as! NSArray)
            self.arrCars = array
            self.loadCars(arrayCars: array)
            RappleActivityIndicatorView.stopAnimation()
        }
    }
    
    func setBorderWidth(){
        
        if AppDelegateVariable.appDelegate.strLanguage == "en" {
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
        }
        else{
            viewPickAddressAr.layer.borderColor = UIColor.lightGray.cgColor
            viewPickAddressAr.layer.borderWidth = 1
            
            viewDestinationAddressAr.layer.borderColor = UIColor.lightGray.cgColor
            viewDestinationAddressAr.layer.borderWidth = 1
            viewDestinationAddressAr.isHidden = true
            
            buttonConfirmBookingAr.layer.cornerRadius = 3
            btnCancelAr.layer.cornerRadius = 3
            
            viewEstimateAr.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
            viewEstimateAr.layer.borderWidth = 0.5
            viewEstimateAr.layer.cornerRadius = 3
            viewEstimateAr.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        setShowAndHideViews(viewEnglish, vArb: viewArabic)
        setBorderWidth()
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
            
            if i < (self.arrCars.count - 1)
            {
                let lbl_line = UILabel(frame: CGRect(x: wd + i * wd, y: 20, width: 1, height: 50))
                lbl_line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                if  AppDelegateVariable.appDelegate.strLanguage == "en" {
                    self.scrollViewCars.addSubview(lbl_line)
                }else{
                    self.scrollViewCarsAr.addSubview(lbl_line)
                }
                ///self.scrollViewCars.addSubview(lbl_line)
            }
            
            //            let imgUrl = dict.object(forKey: "car_type") as? String
            
            let car_icon = UIImageView(frame: CGRect(x: wd/2 - 30 + i * wd, y: 25, width: 60, height: 40))
            car_icon.image = #imageLiteral(resourceName: "carIcon")
            
            car_icon.contentMode = UIViewContentMode.scaleAspectFit
            
            let lblCarName = UILabel(frame: CGRect(x: i * wd, y:65, width: wd, height: 21))
            lblCarName.textAlignment = .center
            lblCarName.text = dict.object(forKey: "car_type") as? String
            lblCarName.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            lblCarName.font = UIFont .systemFont(ofSize: 13)
           
            
            let btnTapCar = UIButton(frame: CGRect(x: i * wd, y: 0, width: wd, height: 90))
            if  AppDelegateVariable.appDelegate.strLanguage == "en" {
                self.scrollViewCars.addSubview(lblTime)
                self.scrollViewCars.addSubview(btnTapCar)
                self.scrollViewCars.addSubview(lblCarName)
                self.scrollViewCars.addSubview(car_icon)
            }else{
                self.scrollViewCarsAr.addSubview(lblTime)
                self.scrollViewCarsAr.addSubview(btnTapCar)
                self.scrollViewCarsAr.addSubview(lblCarName)
                self.scrollViewCarsAr.addSubview(car_icon)
            }
            
            btnTapCar .addTarget(self, action: #selector(tapCarBottom), for: UIControlEvents.touchUpInside)
            btnTapCar.tag = i
        }
        if  AppDelegateVariable.appDelegate.strLanguage == "en" {
            scrollViewCars.showsHorizontalScrollIndicator = false
            scrollViewCars .contentSize = CGSize(width: 6*wd, height: 90)
            viewBottom.isHidden = false
        }else{
            scrollViewCarsAr.showsHorizontalScrollIndicator = false
            scrollViewCarsAr .contentSize = CGSize(width: 6*wd, height: 90)
            viewBottomAr.isHidden = false
        }
      
    }
    
    func tapCarBottom(sender:UIButton)  {
        
        let popUp : ViewDetailCar = Bundle.main.loadNibNamed("ViewDetailCar", owner: 0, options: nil)![0] as? UIView as! ViewDetailCar
        popUp.cat_type.text = (self.arrCars.object(at: sender.tag) as! NSDictionary) .object(forKey: "car_type") as? String
        popUp.frame = self.view.frame
       
        self.view.addSubview(popUp)
    }
    
    // MARK: SlideNavigationController Delegate
    @IBAction func actionLeftMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    @IBAction func actionRightMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }

    // MARK: - Bottom Buttons Methods
    
    
    @IBAction func tapBookNow(_ sender: Any) {
        
        tagBookNow = 1;
        if  AppDelegateVariable.appDelegate.strLanguage == "en" {
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
        }else {
            imagePicDotAr.image = #imageLiteral(resourceName: "dotGreen")
            imageDestDotAr.tintColor = UIColor.red
            imageDestDotAr.image = imageDestDotAr.image?.withRenderingMode(.alwaysTemplate)
            
            viewDestinationAddressAr.isHidden = false
            self.viewConfirmBtnsAr.isHidden = false
            
            destinationCordinate = pickUpCordinate
            
            UIView.animate(withDuration: 0.2)
            {
                self.viewBottomAr.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
            }
        }
       
    }
    
    @IBAction func tapCacelBooking(_ sender: Any)
    {
        if AppDelegateVariable.appDelegate.strLanguage == "en" {
            viewDestinationAddress.isHidden = true
            tagBookNow = 0;
            imagePicDot.image = #imageLiteral(resourceName: "Search")
            mapView.clear()
            imgMidPin.isHidden = false
            
            UIView.animate(withDuration: 0.2)
            {
                self.viewBottom.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT-134  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
            }
        }else{
            viewDestinationAddressAr.isHidden = true
            tagBookNow = 0;
            imagePicDotAr.image = #imageLiteral(resourceName: "Search")
            mapView.clear()
            imgMidPinAr.isHidden = false
            
            UIView.animate(withDuration: 0.2)
            {
                self.viewBottomAr.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT-134  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
            }
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
      //  obj.pickUpAddress = lblPickAddress.text!
        obj.pickUpCordinate = pickUpCordinate
        navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    // MARK:
    // MARK: - MapView Delegate
    
    func updateLocation()
    {
        let lat = locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self as GMSMapViewDelegate
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
        mapView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenSize.SCREEN_WIDTH, height: Constant.ScreenSize.SCREEN_HEIGHT)
        if AppDelegateVariable.appDelegate.strLanguage == "en" {
             viewForMap.addSubview(mapView)
        }else{
             viewForMapAr.addSubview(mapView)
        }
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
                        if AppDelegateVariable.appDelegate.strLanguage == "en"{
                            if self.tagBookNow == 0
                            {
                                self.lblPickAddress.text = addressString
                            }
                            if self.tagBookNow == 1
                            {
                                self.lblDestinationAddress.text = addressString
                            }
                        }else {
                            if self.tagBookNow == 0
                            {
                                self.lblPickAddressAr.text = addressString
                            }
                            if self.tagBookNow == 1
                            {
                                self.lblDestinationAddressAr.text = addressString
                            }
                        }
                    }
                }
                else
                {
                    if AppDelegateVariable.appDelegate.strLanguage == "en"{
                        self.lblPickAddress.text = "location not found"
                    }else {
                        self.lblPickAddressAr.text = "location not found"
                    }
                }
            }catch{
                print("error")
            }
            
        }
        
        
    }
    
    @IBAction func tapConfirmBooking(_ sender: Any)
    {
        
        if self.tagBookNow == 1 {
            if  AppDelegateVariable.appDelegate.strLanguage == "en" {
                
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
            else{
                
                viewEstimateAr.isHidden = false
                imgMidPinAr.isHidden = true
                
                let marker_pick = GMSMarker()
                marker_pick.position = pickUpCordinate
                marker_pick.title = lblPickAddressAr.text
                marker_pick.map = mapView
                marker_pick.icon = #imageLiteral(resourceName: "markerLocation")
                
                let marker_dest = GMSMarker()
                marker_dest.position = destinationCordinate
                marker_dest.title = lblPickAddressAr.text
                marker_dest.map = mapView
                marker_dest.icon = #imageLiteral(resourceName: "markerDesitnation")
                
                getPolylineRoute(from: pickUpCordinate, to: destinationCordinate)
                
                self.tagBookNow = 2
            }
        }
        else
        {
            //            username:Testapplication
            //            purpose:PTPT
            //            pickup_area:fnfkjsdnfkjndskj
            //            pickup_date:11/10/2017
            //            drop_area:rkgtjerkjgekjgterjgkjen
            //            pickup_time:2:5:15
            //            pickup_address:flsdjifhiuhgkjg
            //            taxi_type:SUV
            //            departure_time:2:5:15
            //            departure_date:11/10/2017
            //            distance:0
            //            amount:100
            //            address:fjhdsngfdhsfhg
            //            payment_media:cash
            //            km:1
            //            lat:26.877776860167394
            //            long:75.75385887175798
            //            random:95965626599989895
            //            

            

            let random : String = "3233535"
            let dic = NSMutableDictionary()
            
            dic.setValue("Testapplication", forKey: "username")
            dic.setValue("PTPT", forKey: "purpose")
            dic.setValue("24/06/2017", forKey: "pickup_date")
            dic.setValue("05:05:77 am", forKey: "pickup_time")            
            dic.setValue("SUV", forKey: "taxi_type")
            dic.setValue("05:05:77 am", forKey: "departure_time")
            dic.setValue("24/06/2017", forKey: "departure_date")
            dic.setValue("15", forKey: "distance")
            dic.setValue("100", forKey: "amount")
            dic.setValue("jaipur", forKey: "address")
            dic.setValue("Cash", forKey: "payment_media")
            dic.setValue("15", forKey: "km")

            dic.setValue(String (format: "%@", "26.877714955302803"), forKey: "lat")
            dic.setValue(String (format: "%@", "75.75397621840239"), forKey: "long")
            dic.setValue(random, forKey: "random")

            dic.setValue("a13e96c6d8c53c14144ab82d6a026b09a1d35d23", forKey: "device_id")
            
            if AppDelegateVariable.appDelegate.strLanguage == "en"{
                
                dic.setValue(lblPickAddress.text, forKey: "pickup_address")
                dic.setValue(lblPickAddress.text, forKey: "pickup_area")
                dic.setValue(lblDestinationAddress.text, forKey: "drop_area")
            }
            else{
                dic.setValue(lblPickAddressAr.text, forKey: "pickup_address")
                dic.setValue(lblPickAddressAr.text, forKey: "pickup_area")
                dic.setValue(lblDestinationAddressAr.text, forKey: "drop_area")
            }
            
            
            ////<<<<<<< HEAD
            //            dic.setValue("Jaipur", forKey: "pickup_area")
            //            dic.setValue("21/06/2017", forKey: "pickup_date")
            //            dic.setValue("05:05 am", forKey: "pickup_time")
            //            dic.setValue("Jaipur", forKey: "drop_area")
            //            dic.setValue("jaipur", forKey: "area")
            //            dic.setValue("", forKey: "landmark")
            //            dic.setValue("jaipur", forKey: "pickup_address")
//            dic.setValue("", forKey: "timetype")
//            dic.setValue("", forKey: "transfer")
//            dic.setValue("", forKey: "promo_code")
//            dic.setValue("", forKey: "area")
//            dic.setValue("", forKey: "landmark")
//            dic.setValue("", forKey: "flight_number")
//            dic.setValue("", forKey: "package")
//
            //=======
                       // let str = "http://taxiappsourcecode.com/api/index.php?option=booking_request"
            
            RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
            
            
            var parameterString = String(format : "booking_request")

            
            for (key, value) in dic
            {
                parameterString = String (format: "%@&%@=%@", parameterString,key as! CVarArg,value as! CVarArg)
                
                // println("\(key) -> \(value)")
            }
            
            Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
                
                if status == true
                {
                    var userDict = (dataDictionary.object(forKey: "result") as! NSDictionary).mutableCopy() as! NSMutableDictionary
                    userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict)
                    
                    USER_DEFAULT.set("1", forKey: "isLogin")
                    USER_DEFAULT.set(userDict, forKey: "userData")
                    AppDelegateVariable.appDelegate.sliderMenuControllser()
                    
                    //  print("Location:  \(userInfo)")
                    //  NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: (userInfo as AnyObject) as? [AnyHashable : Any])
                    // AppDelegateVariable.appDelegate.loginInMainView()
                }
                else
                    
                {
                    Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
                }
            }
            
            
//            Utility.sharedInstance.postDataInDataForm(heheader: <#String#>, ader: parameterString, inVC: self) { (dataDictionary, msg, status) in
//                
//     
//                if status == true
//                {
//                    var userDict = (dataDictionary.object(forKey: "result") as! NSDictionary).mutableCopy() as! NSMutableDictionary
//                    userDict = AppDelegateVariable.appDelegate.convertAllDictionaryValueToNil(userDict)
//                    
//                    USER_DEFAULT.set("1", forKey: "isLogin")
//                    USER_DEFAULT.set(userDict, forKey: "userData")
//                    
//                    
//                    //print("Location:  \(userInfo)")
//                    /// NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: (userInfo as AnyObject) as? [AnyHashable : Any])
//                    // AppDelegateVariable.appDelegate.loginInMainView()
//                    
//                    
//                }
//                else
//                    
//                {
//                    Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
//                }
//                
//            }
            
        }
    }

    
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        Alamofire.request(url.absoluteString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            print(response);
            
            do {
                
                if (response.result.value != nil)
                {
                    
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
    
        if tagBookNow != 2 {
         
            acController = GMSAutocompleteViewController()
            acController.delegate = self
            present(acController, animated: true, completion: nil)
        }
        
        
    }
    
    // MARK: - Tap Search
    
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
        {
            //print("Place name: \(place.name)")
            // print("Place address: \(place.formattedAddress)")
            // print("Place attributions: \(place.attributions)")
            dismiss(animated: true, completion: nil)
            let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 10.0)
            mapView.camera = camera
            
            if tagBookNow == 0
            {
                pickUpCordinate = place.coordinate
            }
            else
            {
                destinationCordinate = place.coordinate
            }
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

