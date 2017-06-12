//
//  HomeViewController.swift
//  Tawsila
//
//  Created by Sanjay on 11/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController ,GMSMapViewDelegate ,UISearchBarDelegate    {

    @IBOutlet var mapView: GMSMapView!
  //  @IBOutlet var imageMarker: UIImageView!
  //  @IBOutlet var serchBar: UISearchBar!

    var acController = GMSAutocompleteViewController()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
      //  serchBar.placeholder = "Select pickup location"
      //  serchBar.delegate = self
        
        // -- Locaton Manager
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        // -- google map
        
        let lat = locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude

        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self as GMSMapViewDelegate
        
        self.perform(#selector(updateLocation), with:1)

    }

    func updateLocation()
    {
        let lat = locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude
        
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 6.0)
        mapView.camera = camera
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK:
    // MARK: - Tap Search
    
    @IBAction func tapSearch(_ sender: Any) {
        
        acController = GMSAutocompleteViewController()
        acController.delegate = self as? GMSAutocompleteViewControllerDelegate;
        present(acController, animated: true, completion: nil)
        acController.delegate = self as Any as? GMSAutocompleteViewControllerDelegate
    }
    
    // MARK:
    // MARK: - Bottom Buttons Methods

    
    @IBAction func tapBookNow(_ sender: Any) {
        
    }
    
    @IBAction func tapRideLater(_ sender: Any) {
        
        let obj : RideLaterVC = RideLaterVC(nibName: "RideLaterVC", bundle: nil)
        navigationController?.pushViewController(obj, animated: true)
        
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



