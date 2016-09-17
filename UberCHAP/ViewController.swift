//
//  ViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, LocationServiceDelegate {

    @IBOutlet weak var gpsLabel: UILabel!

    let locationService = LocationService()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.delegate = self
        locationService.toggle(enable: true)
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        gpsLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
    }

}

