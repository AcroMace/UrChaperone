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
        // Don't conflict with other notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()

        // Schedule the new one
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 3)
        localNotification.alertBody = "Swipe to go home"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.repeatInterval = .Minute
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

}
