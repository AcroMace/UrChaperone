//
//  CallUberViewController.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-18.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit

class CallUberViewController: UIViewController {

    static let identifier = String(CallUberViewController)
    static let segue = "callUber"
    var didShowUber = false

    static func createInstance() -> CallUberViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifier) as! CallUberViewController
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        /**
         * We use the flag since the view is shown again when the user closes the Uber request
         * window. Otherwise, the user would just be shown the Uber window again.
         **/
        if !didShowUber {
            let requestButton = UberService.createRequestButton(self)
            requestButton.sendActionsForControlEvents(.TouchUpInside)
            didShowUber = true
        }
        performSegueWithIdentifier(CallUberViewController.segue, sender: self)
    }

}
