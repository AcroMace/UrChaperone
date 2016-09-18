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

    // Minimum distance the user has to travel from their homes before they are
    // asked to book a ride
    static let minDistanceBeforePushInMeters: Double = 50

    let locationService = LocationService()
    var homeLocation: CLLocationCoordinate2D? = nil
    var lastCoordinate: CLLocationCoordinate2D? = nil
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
        lastCoordinate = coordinate

        // Save the home location if we have never set one before
        if homeLocation == nil {
            saveHomeLocation(coordinate)
        }

        // This is guaranteed to pass since we set it above if it's nil
        guard let `homeLocation` = homeLocation else { return }
        let distance = coordinatesDistance(homeLocation, coordinate2: coordinate)
        distances.append(distance)

        if distance > ConfiguredViewController.minDistanceBeforePushInMeters {
            // Stop getting the location after we establish that the user has left their house
            locationService.toggle(false)
        }
    }

    @IBAction func saveHomeLocation(sender: AnyObject) {
        if let lastCoordinate = lastCoordinate {
            saveHomeLocation(lastCoordinate)
        }
    }

    // Save the new home location
    private func saveHomeLocation(coordinate: CLLocationCoordinate2D) {
        addHomePinToMap(at: coordinate)
        LocationService.saveHomeLocation(coordinate)
        homeLocation = coordinate
    }

    // Remove all previous pins from the map and add a new Home pin
    private func addHomePinToMap(at coordinate: CLLocationCoordinate2D) {
        // Remove all previous annotations
        mapView.removeAnnotations(mapView.annotations)

        // Add the new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Home"
        mapView.addAnnotation(annotation)
    }

    // Get the distance between two coordinates
    private func coordinatesDistance(coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) -> Double {
        return LocationService.coordinateToLocation(coordinate1).distanceFromLocation(LocationService.coordinateToLocation(coordinate2))
    }

}
