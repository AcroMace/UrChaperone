//
//  LoginViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import UberRides

class LoginViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = UberService.createLoginButton()
        loginButton.presentingViewController = self
        loginButton.delegate = self
        stackView.addArrangedSubview(loginButton)
    }

    private func checkIfAlreadyAuthorized() {
        if UberService.getToken() != nil {
            performSegueWithIdentifier("alreadyAuthorized", sender: self)
        }
    }

    private func createLoginButton() -> LoginButton {
        let scopes: [UberRides.RidesScope] = [.Profile, .Places, .Request]
        let loginManager = LoginManager(loginType: .Native)
        let loginButton = LoginButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: 400.0, height: 80.0)), scopes: scopes, loginManager: loginManager)
        loginButton.presentingViewController = self
        loginButton.delegate = self

        loginButton.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0))

        return loginButton
    }

}

// MARK: LoginButtonDelegate

extension LoginViewController: LoginButtonDelegate {

    func loginButton(button: LoginButton, didCompleteLoginWithToken accessToken: AccessToken?, error: NSError?) {
        guard let accessToken = accessToken, tokenString = accessToken.tokenString else {
            return
        }
        print("Got access token: \(accessToken)")
        UberService.saveToken(tokenString)
        performSegueWithIdentifier("finishAuthorization", sender: self)
    }

    func loginButton(button: LoginButton, didLogoutWithSuccess success: Bool) {
        print("Logged out with success \(success)")
    }

}
