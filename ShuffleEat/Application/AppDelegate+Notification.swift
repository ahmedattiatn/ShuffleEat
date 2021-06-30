//
//  AppDelegate+Notification.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 20/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {
    //MARK:- UNUSerNotificationDelegates
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Usrinfo associated with notification == \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
}
