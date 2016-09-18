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

        // Opened a push notification from when the app was killed
        if let localNotification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] {
            print("App cold opened from local notification: \(localNotification)")
            application.applicationIconBadgeNumber = 0;
        }

        return true
    }

    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Probably no need to show alerts when the app is open
        application.applicationIconBadgeNumber = 0
        print("didReceiveLocalNotification")

        let applicationState = UIApplication.sharedApplication().applicationState
        // Received a push notification while the back
        if applicationState == .Background || applicationState == .Inactive {
            print("didReceiveLocalNotification from background")
            UIApplication.sharedApplication().windows.first?.rootViewController = CallUberViewController.createInstance()
        }
    }

    // MARK: Uber stuff

    @available(iOS 9, *)
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        let handledURL = RidesAppDelegate.sharedInstance.application(app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        
        if (!handledURL) {
            // Other URL parsing logic
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handledURL = RidesAppDelegate.sharedInstance.application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
        if (!handledURL) {
            // Other URL parsing logic
        }
        
        return true
    }

}
