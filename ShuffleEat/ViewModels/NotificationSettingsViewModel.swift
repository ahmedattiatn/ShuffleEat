//
//  NotificationSettingsViewModel.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 24/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

class SettingsViewModel {
    
    var delegate:SettingsViewModelProtocol? = nil
    
    func cancelNotification(notificationID: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationID])
        
    }
    
    func triggeNotificationAt(date:Date) {
        let userNotification = UNUserNotificationCenter.current()
        checkAuthorizationFor(userNotification)
        // center.removeAllPendingNotificationRequests()
        let content = setContent()
        let fireDate = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: true)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        userNotification.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
    
    func checkAuthorizationFor(_ userNotification:UNUserNotificationCenter)  {
        userNotification.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notifications is granted!")
            } else {
                print("Notifications is not granted So please update your settings!")
                self.delegate?.notificationAuthorization()
                
            }
            
        }
    }
    
    func setContent()-> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        let defaultContent = NotificationSettings()
        content.title = defaultContent.title
        content.body = defaultContent.body
        content.sound = .default
        return content
    }
    
}
