//
//  AppDelegate.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import UberRides

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // If true, all requests will hit the sandbox, useful for testing
        Configuration.setSandboxEnabled(true)
        // If true, Native login will try and fallback to using Authorization Code Grant login (for privileged scopes). Otherwise will redirect to App store
        Configuration.setFallbackEnabled(false)

        // Register for push notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))

        if let localNotification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] {
            application.applicationIconBadgeNumber = 0;
        }

        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Probably no need to show alerts when the app is open
        application.applicationIconBadgeNumber = 0
    }

}
