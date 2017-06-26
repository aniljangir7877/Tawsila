//
//  PickUPRideVC.swift
//  Tawsila
//
//  Created by Sanjay on 21/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import GoogleMaps

class PickUPRideVC: UIViewController , GMSMapViewDelegate {

    var mapView: GMSMapView!

    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var viewForMap: UIView!
    
    var locationCordinate : CLLocationCoordinate2D!
    var cordinatePick : CLLocationCoordinate2D!
    var cordinateDrop : CLLocationCoordinate2D!
    
    
    var id_bookint : String!
    var id_driver : String!

    override func viewDidLoad() {
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
        
        locationCordinate = CLLocationCoordinate2DMake(25.00, 75.00)
        
        let marker_pick = GMSMarker()
        marker_pick.position = locationCordinate
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
        
      //  let number = URL(string: "tel://" +)
      //  UIApplication.shared.open(number)

    }
    
    @IBAction func tapCancelRide(_ sender: Any){
        
    }
    
    @IBAction func tapShare(_ sender: Any) {
        
    }
    
    @IBAction func tapLiveCamera(_ sender: Any) {
        
    }
    
    @IBAction func tapMore(_ sender: Any) {
        
    }
    
    
}
