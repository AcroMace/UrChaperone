//
//  LocationService.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import MapKit

protocol LocationServiceDelegate {
    func locationDidUpdate(coordinate: CLLocationCoordinate2D)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    var delegate: LocationServiceDelegate?
    let locationManager = CLLocationManager()

    override init() {
        super.init()

        // RIP battery life
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        // Ask the user for permission to use location
        locationManager.requestAlwaysAuthorization()
    }

    func toggle(enable: Bool) {
        if enable {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else { return }

        let coordinate = locations[0].coordinate

        if UIApplication.shared.applicationState == .active {
            print("Foreground location: \(coordinate)")
        } else {
            print("Background location: \(coordinate)")
        }
        delegate?.locationDidUpdate(coordinate: coordinate)
    }

}
