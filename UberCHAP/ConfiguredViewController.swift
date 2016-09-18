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
    var alreadyDisplayingHomePin = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if let homeLocation = LocationService.getHomeLocation() {
            alreadyDisplayingHomePin = true
            addHomePinToMap(at: homeLocation)
        }

        locationService.delegate = self
        locationService.toggle(true)
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
        if !alreadyDisplayingHomePin && coordinates.count == 1 {
            addHomePinToMap(at: coordinate)
            LocationService.saveHomeLocation(coordinate)
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

}
