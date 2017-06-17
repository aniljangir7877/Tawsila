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
import Alamofire


class HomeViewControlle: UIViewController ,GMSMapViewDelegate ,SlideNavigationControllerDelegate    {
    
    var mapView: GMSMapView!
    @IBOutlet var viewForMap: UIView!
    
    @IBOutlet var lblPickAddress: UILabel!
    @IBOutlet var viewPickAddress: UIView!
    @IBOutlet var viewDestinationAddress: UIView!
    @IBOutlet var lblDestinationAddress: UILabel!
    
    @IBOutlet var imageDestDot: UIImageView!
    @IBOutlet var imagePicDot: UIImageView!
    
    @IBOutlet var buttonConfirmBooking: UIButton!
    var acController = GMSAutocompleteViewController()
    var locationManager = CLLocationManager()
    
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var scrollViewCars: UIScrollView!
    
    @IBOutlet var viewEstimate: UIView!
    
    //   15 - 06 - 17
    
    @IBOutlet var imgMidPin: UIImageView!
    var pickUpCordinate : CLLocationCoordinate2D!
    var destinationCordinate : CLLocationCoordinate2D!
    var tagBookNow : Int!
    
    
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
        
        viewEstimate.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        viewEstimate.layer.borderWidth = 0.5
        viewEstimate.layer.cornerRadius = 3
        viewEstimate.isHidden = true
        
        // -- Locaton Manager
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self .perform( #selector(updateLocation), with: 1, afterDelay: 0)
        
        loadCars(arrayCars: 5)
        
    }
    
    // MARK:
    // MARK: - Bottom View
    
    func loadCars(arrayCars: Any)
    {
        
        for i in 0 ... 5 {
            
            let lblTime = UILabel(frame: CGRect(x: i * 70, y: 0, width: 70, height: 25))
            lblTime.textAlignment = .center
            lblTime.text = "10 min"
            lblTime.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            lblTime.font = UIFont .systemFont(ofSize: 13)
            self.scrollViewCars.addSubview(lblTime)
            
            if i < 5
            {
                let lbl_line = UILabel(frame: CGRect(x: 69 + i * 70, y: 20, width: 1, height: 50))
                lbl_line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.scrollViewCars.addSubview(lbl_line)
            }
            
            let car_icon = UIImageView(frame: CGRect(x: 5 + i * 70, y: 25, width: 60, height: 40))
            car_icon.image = #imageLiteral(resourceName: "carIcon")
            self.scrollViewCars.addSubview(car_icon)
            car_icon.contentMode = UIViewContentMode.scaleAspectFit
            
            let lblCarName = UILabel(frame: CGRect(x: i * 70, y:65, width: 70, height: 21))
            lblCarName.textAlignment = .center
            lblCarName.text = "Car"
            lblCarName.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            lblCarName.font = UIFont .systemFont(ofSize: 13)
            self.scrollViewCars.addSubview(lblCarName)
            
            let btnTapCar = UIButton(frame: CGRect(x: i * 70, y: 0, width: 70, height: 90))
            self.scrollViewCars.addSubview(btnTapCar)
            btnTapCar .addTarget(self, action: #selector(tapCarBottom), for: UIControlEvents.touchUpInside)
        }
        scrollViewCars.showsHorizontalScrollIndicator = false
        scrollViewCars .contentSize = CGSize(width: 6*70, height: 90)
    }
    
    
    func tapCarBottom(sender:UIButton)  {
        
        let popUp : ViewDetailCar = Bundle.main.loadNibNamed("ViewDetailCar", owner: 0, options: nil)![0] as? UIView as! ViewDetailCar
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
        
        destinationCordinate = pickUpCordinate
        
        UIView.animate(withDuration: 0.2) {
            self.viewBottom.frame =  CGRect(x: 0, y: Constant.ScreenSize.SCREEN_HEIGHT  , width: Constant.ScreenSize.SCREEN_WIDTH, height: 134)
        }
    }
    
    @IBAction func tapRideLater(_ sender: Any) {
        
        let obj : RideLaterVC = RideLaterVC(nibName: "RideLaterVC", bundle: nil)
        obj.pickUpAddress = lblPickAddress.text!
        navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    // MARK:
    // MARK: - MapView Delegate
    
    func updateLocation()
    {
        let lat = locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 6.0)
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
        else
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
                        else
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
        
        // let bounds = GMSCoordinateBounds(coordinate: pickUpCordinate, coordinate: destinationCordinate)
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK:
    // MARK: - Tap Search
    
    @IBAction func tapSearch(_ sender: Any) {
        
        //        acController = GMSAutocompleteViewController()
        //        acController.delegate = self as? GMSAutocompleteViewControllerDelegate;
        //        present(acController, animated: true, completion: nil)
        //        acController.delegate = self as Any as? GMSAutocompleteViewControllerDelegate
        
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



