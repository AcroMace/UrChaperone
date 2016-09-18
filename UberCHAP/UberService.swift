//
//  UberService.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import MapKit
import UberRides

class UberService {

    static private let key = "UBER_TOKEN"

    static func createLoginButton() -> LoginButton {
        let scopes: [UberRides.RidesScope] = [.Places, .Request]
        let loginManager = LoginManager(loginType: .Native)
        let loginButton = LoginButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: 400.0, height: 80.0)), scopes: scopes, loginManager: loginManager)

        loginButton.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0))

        return loginButton
    }

    static func createRequestButton(presentingViewController: UIViewController) -> RideRequestButton {
        guard let token = UberService.getToken() else {
            print("ERROR: Attempted to create request button without having authorized to Uber")
            return RideRequestButton()
        }

        let behavior = RideRequestViewRequestingBehavior(presentingViewController: presentingViewController)
        let parameters = RideParametersBuilder().setDropoffPlaceID("home").build()
        let button = RideRequestButton(rideParameters: parameters, requestingBehavior: behavior)
        return button
    }

    static func saveToken(token: String) {
        getInstance().setObject(token, forKey: UberService.key)
    }

    static func getToken() -> String? {
        return getInstance().objectForKey(UberService.key) as? String
    }

    static private func getInstance() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }

}
