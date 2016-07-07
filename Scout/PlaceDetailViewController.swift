//
//  PlaceDetailViewController.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import Alamofire

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var locationCoordinates: UILabel!
    @IBOutlet weak var locationType: UITextView!
    @IBOutlet weak var locationURL: UITextView!
    
    let dataManager = GooglePlacesManager()
    var selectedPlaceID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlaceDetails()
    }

    func fetchPlaceDetails() {
        dataManager.fetchPlaceDetails(self.selectedPlaceID) {responseJSON in
            
            self.name.text = responseJSON["name"] as? String
            self.address.text = responseJSON["formatted_address"] as? String
            
            let geometry = responseJSON["geometry"]
            let location = geometry!!["location"]

            let latitude = location!!["lat"]
            let longitude = location!!["lng"]
            self.locationCoordinates.text = String(format: "Latitude: \(latitude!!) Longitude:\(longitude!!)")
            
            let types = String(responseJSON["types"]!!.description)            
            self.locationType.text = types
            
            self.locationURL.text = responseJSON["url"] as? String
        }
    }
    
}
