//
//  AppDelegate+CoreLocation.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 15/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

extension AppDelegate: LocationManagerProtocol {
    
    func showUpdateLocationSettingsAlert() {
        showLocationPermisisonAlert()
    }
    
    func showLocationPermisisonAlert() {
        let alert = UIAlertController(title: NSLocalizedString("locationErrorTitle",comment: ""), message: NSLocalizedString("locationError",comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            if let url = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
                let notificationCenter = NotificationCenter.default
                notificationCenter.addObserver(self, selector: #selector(self.appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
            }
        })
        alert.addAction(okAction)
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    /* if we remove this (notificationCenter) :
     you will find the Main screen empty in case we return from the settings without allowing the location permission in the app
     */
    
    @objc func appMovedToBackground() {
        print("App moved to background! Ang going to settings ")
        exit(0)
        
    }
}
