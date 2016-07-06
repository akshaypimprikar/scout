
//
//  GooglePlacesManager.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class GooglePlacesManager {
    
    let googleMapsApiKey = "AIzaSyAzYGnwoh4BoTa0KRX97M-N0ypulm_8NeI"

    func fetchPlacesNearCoordinate(coordinate: CLLocationCoordinate2D, radius: Double, completion: ([TopPlace]) -> Void) -> ()
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(googleMapsApiKey)&location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&type=establishment", encoding: .URL).validate().responseJSON { response in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var placesArray = [TopPlace]()
            
            switch response.result {
            case .Success:
                
                let value = response.result.value as! [NSObject : AnyObject]
                if let results = value["results"] as? NSArray {

                    for placeData in results {
                        let place = TopPlace(name: (placeData["name"] as! String), imageURL: (placeData["icon"] as! String), placeid: (placeData["place_id"] as! String))
                        placesArray.append(place)
                    }
                }
                dispatch_async(dispatch_get_main_queue()) {
                    completion(placesArray)
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func fetchPlaceDetails(placeid: String, completion: (AnyObject) -> Void) -> ()
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/place/details/json?key=\(googleMapsApiKey)&placeid=\(placeid)").responseJSON { response in

            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            switch response.result {
            case .Success:
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let value = response.result.value as! [NSObject : AnyObject]
                    if let result = value["result"] as? NSDictionary {
                    completion(result)
                    }
                }
            
            case .Failure:
                print("Request failed with error: \(response.result)")
            }
        }
    }
}
