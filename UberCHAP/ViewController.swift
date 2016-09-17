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

    @IBOutlet weak var tableView: UITableView!

    let locationService = LocationService()
    var coordinates = [CLLocationCoordinate2D]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.delegate = self
        locationService.toggle(enable: true)

        tableView.delegate = self
        tableView.dataSource = self
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coordinate = coordinates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CoordinateTableViewCell.reuseIdentifier) as! CoordinateTableViewCell
        cell.coordinateLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
        return cell
    }

}
