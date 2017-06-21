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

    @IBOutlet var viewForMap: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 25.00, longitude: 75.00, zoom: 10.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self as GMSMapViewDelegate
        mapView.isMyLocationEnabled = true
        mapView.camera = camera
        mapView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenSize.SCREEN_WIDTH, height: Constant.ScreenSize.SCREEN_HEIGHT)
        viewForMap.addSubview(mapView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
