//
//  ViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import MapKit
import UberRides

class ViewController: UIViewController, LocationServiceDelegate {

    @IBOutlet weak var loginButtonContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    let locationService = LocationService()
    var coordinates = [CLLocationCoordinate2D]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.delegate = self
        locationService.toggle(true)

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Uber
        let scopes: [UberRides.RidesScope] = [.Profile, .Places, .Request]
        let loginManager = LoginManager(loginType: .Native)
        let loginButton = LoginButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: 400.0, height: 80.0)), scopes: scopes, loginManager: loginManager)
        loginButton.presentingViewController = self
        loginButton.delegate = self
        loginButtonContainerView.addSubview(loginButton)
    }

    func locationDidUpdate(coordinate: CLLocationCoordinate2D) {
        coordinates.append(coordinate)
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let coordinate = coordinates[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(CoordinateTableViewCell.reuseIdentifier) as! CoordinateTableViewCell
        cell.coordinateLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
        return cell
    }

}

extension ViewController: LoginButtonDelegate {
    
    // Mark: LoginButtonDelegate
    
    func loginButton(button: LoginButton, didLogoutWithSuccess success: Bool) {
        // success is true if logout succeeded, false otherwise
    }
    
    func loginButton(button: LoginButton, didCompleteLoginWithToken accessToken: AccessToken?, error: NSError?) {
        if let accessToken = accessToken {
            // AccessToken Saved
            print(accessToken)
        }
    }

}
