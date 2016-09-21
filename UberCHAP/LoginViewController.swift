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

    @IBOutlet weak var authorizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a login button
        let loginButton = UberService.createLoginButton()
        loginButton.presentingViewController = self
        loginButton.delegate = self
        view.addSubview(loginButton)

        // Hacky login button location configuration since I couldn't get AutoLayout
        // to render the button correctly 10 minutes before demoing
        //    ... a button 80 points high,
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.width * 0.8, height: 60.0))
        //    ... at 80% down the screen
        loginButton.frame = CGRect(origin: CGPoint(x: (view.frame.width - frame.width)/2, y: view.frame.height * 0.8), size: CGSize(width: frame.width, height: frame.height))

        checkIfAlreadyAuthorized()
    }

    private func checkIfAlreadyAuthorized() {
        /**
         * Check if the auth token is saved and use it if it is
         *
         * Note that when the token expires, the user would be screwed since there is
         * currently no way to log out of the app
         */
        if UberService.getToken() != nil {
            performSegueWithIdentifier("alreadyAuthorized", sender: self)
        }
    }

    private func createLoginButton() -> LoginButton {
        let scopes: [UberRides.RidesScope] = [.Profile, .Places, .Request]
        let loginManager = LoginManager(loginType: .Native)
        let loginButton = LoginButton(frame: CGRect.zero, scopes: scopes, loginManager: loginManager)
        loginButton.presentingViewController = self
        loginButton.delegate = self

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
        // It seemed like the user could see the log out button if they logged in,
        // deleted the app, and reinstalled it. No idea why.
        print("Logged out with success \(success)")
    }

}
