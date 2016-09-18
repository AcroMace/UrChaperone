//
//  NotificationService.swift
//  UberCHAP
//
//  Created by Andy Cho on 2016-09-17.
//  Copyright © 2016 Students Concerned About Party Night. All rights reserved.
//

import UIKit
import CoreFoundation

struct NotificationService {

    static func scheduleNotification() {
        disableNotifications()

        // Schedule the new one
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate()
        localNotification.alertTitle = "Swipe for a ride home"
        localNotification.alertBody = "Call an Uber"
        localNotification.hasAction = true
        localNotification.alertAction = "Slide to go home"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.repeatInterval = .Minute
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    static func disableNotifications() {
        // Don't conflict with other notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }

}
