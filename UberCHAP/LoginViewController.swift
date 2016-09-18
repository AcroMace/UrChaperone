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

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = UberService.createLoginButton()
        loginButton.presentingViewController = self
        loginButton.delegate = self
        view.addSubview(loginButton)

        // :(
        loginButton.frame = CGRect(origin: CGPoint(x: (view.frame.width - loginButton.frame.width)/2, y: view.frame.height * 0.8), size: loginButton.frame.size)

        checkIfAlreadyAuthorized()

        LocationService.search("256 Blair St")
    }

    private func checkIfAlreadyAuthorized() {
        print("Token: \(UberService.getToken())")
        if UberService.getToken() != nil {
            performSegueWithIdentifier("alreadyAuthorized", sender: self)
        }
    }

    private func createLoginButton() -> LoginButton {
        let scopes: [UberRides.RidesScope] = [.Profile, .Places, .Request]
        let loginManager = LoginManager(loginType: .Native)
        let frame = CGRect(origin: CGPointZero, size: CGSize(width: 200, height: 80.0))
        let loginButton = LoginButton(frame: frame, scopes: scopes, loginManager: loginManager)
        loginButton.frame = frame
        loginButton.frame.size = frame.size
        loginButton.presentingViewController = self
        loginButton.delegate = self

        return loginButton
    }

}

// MARK: LoginButtonDelegate

extension LoginViewController: LoginButtonDelegate {

    func loginButton(button: LoginButton, didCompleteLoginWithToken accessToken: AccessToken?, error: NSError?) {
        print("Login button returned")
        print(accessToken)
        print(error)
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
