//
//  TopPlacesViewController.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import CoreLocation

class TopPlacesViewController: UITableViewController, CLLocationManagerDelegate {

    var topPlaces:[TopPlace] = []
    let locationManager = CLLocationManager()
    let dataManager = GooglePlacesManager()
    let searchRadius: Double = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        self.refreshControl?.addTarget(self, action: #selector(TopPlacesViewController.handlePullToRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if topPlaces.count != 0 {
            return topPlaces.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("topPlaceCell", forIndexPath: indexPath) as! TopPlaceCell

        if topPlaces.count > 0 {
            let topPlace = topPlaces[indexPath.row] as TopPlace
            cell.topPlace = topPlace
        }

        return cell
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    

    @IBAction func refreshPlaces(sender: AnyObject) {
        
        locationManager.startUpdatingLocation()
    }
    
    func fetchTopPlacesNearby(coordinate: CLLocationCoordinate2D) {
        
        dataManager.fetchPlacesNearCoordinate(coordinate, radius:searchRadius) {places in
            self.topPlaces = places
            self.tableView.reloadData()
        }
    }
    
    func handlePullToRefresh(refreshControl: UIRefreshControl) {
        
        locationManager.startUpdatingLocation()
        refreshControl.endRefreshing()
    }

    // MARK: - CLLocationManagerDelegate
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {

                locationManager.stopUpdatingLocation()
                fetchTopPlacesNearby(location.coordinate)
            }
        }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlaceDetails" {
            if let tableViewCell = sender as? UITableViewCell
            {
                if let placeDetailViewController = segue.destinationViewController as? PlaceDetailViewController {
                    
                    let indexPath = tableView.indexPathForCell(tableViewCell)
                    placeDetailViewController.selectedPlaceID = topPlaces[indexPath!.row].placeid
                }
            }
        }
    }
}
