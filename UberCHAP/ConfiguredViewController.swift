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

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.delegate = self
        locationService.toggle(true)
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
        if coordinates.count == 1 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Home"
            mapView.addAnnotation(annotation)
        }
    }

    @IBAction func saveHomeLocation(sender: AnyObject) {
        if let lastCoordinate = coordinates.last {
            LocationService.saveHomeLocation(lastCoordinate)
        }
    }

}
