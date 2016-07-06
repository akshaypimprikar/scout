//
//  MapViewController.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var placesClient: GMSPlacesClient?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.sharedClient()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManagerDelegate
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locationManager.stopUpdatingLocation()

            if let location = locations.first {

                let camera = GMSCameraPosition.cameraWithLatitude(location.coordinate.latitude,
                                                                  longitude: location.coordinate.longitude, zoom: 12)
                let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
                mapView.myLocationEnabled = true
                mapView.settings.myLocationButton = true
                mapView.padding = UIEdgeInsetsMake(0.0, 0.0, 50.0, 0.0)
                self.view = mapView
            }
        }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
}
