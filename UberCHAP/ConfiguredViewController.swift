//
//  ConfiguredViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import MapKit
import UberRides

class ConfiguredViewController: UIViewController, LocationServiceDelegate  {

    @IBOutlet weak var mapView: MKMapView!

    let locationService = LocationService()
    var coordinates = [CLLocationCoordinate2D]()
    var homeLocation: CLLocationCoordinate2D? = nil
    var distances = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let homeLocation = LocationService.getHomeLocation() {
            self.homeLocation = homeLocation
            addHomePinToMap(at: homeLocation)
        }

        locationService.delegate = self
        locationService.toggle(true)
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
        if homeLocation == nil && coordinates.count == 1 {
            addHomePinToMap(at: coordinate)
            LocationService.saveHomeLocation(coordinate)
        }

        if let homeLocation = homeLocation {
            let distance = coordinatesDistance(homeLocation, coordinate2: coordinate)
            distances.append(distance)
            print(distance)
        }
    }

    @IBAction func saveHomeLocation(sender: AnyObject) {
        if let lastCoordinate = coordinates.last {
            LocationService.saveHomeLocation(lastCoordinate)
        }
    }

    private func addHomePinToMap(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Home"
        mapView.addAnnotation(annotation)
    }

    private func coordinatesDistance(coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) -> Double {
        let point1 = MKMapPointMake(coordinate1.latitude, coordinate1.longitude)
        let point2 = MKMapPointMake(coordinate2.latitude, coordinate2.longitude)
        return MKMetersBetweenMapPoints(point1, point2)
    }

    // showDebug

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let debugViewController = segue.destinationViewController as? DebugViewController {
            debugViewController.distances = distances
        }
    }
    
}
