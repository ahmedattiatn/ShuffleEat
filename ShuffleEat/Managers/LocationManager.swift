//
//  LocationManager.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import CoreLocation



/******For Authorization Requesting******/

/* In https://www.tfzx.net/article/605369.html voir section : Swift 4 and iOS 11
 
 Probleme : Current location permission dialog disappears too quickly
 
 Solution :
 
 let locationManager = CLLocationManager() : must be declared as a global let
 let locationManager = CLLocationManager() : must be declared as a global let
 
 let locationManager = CLLocationManager() : must be declared as a global let

 */

protocol LocationManagerProtocol {
    func showUpdateLocationSettingsAlert()
}

class LocationManager :NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var delegate : LocationManagerProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func initLocationServices() {
        print("Init Location Services")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func getCurrentLocation()-> Coordinate {
        var userLatitude: Double = 0
        var userLongitude: Double = 0
        if let current : CLLocation = locationManager.location {
            userLongitude = current.coordinate.longitude
            userLatitude = current.coordinate.latitude
        }
        return Coordinate(latitude: userLatitude,longitude: userLongitude)
    }
    
    func distanceFrom(location: Coordinate)-> Double {
        let currentLocation = getCurrentLocation()
        let userLatitude = currentLocation.latitude
        let userLongitude = currentLocation.longitude
        let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        let placeLocation = CLLocation(latitude: (location.latitude), longitude: location.longitude )
        return Double(userLocation.distance(from: placeLocation))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("did Change Authorization",status.rawValue)
        checkingLocationAuthorization(status)
    }
    
    func checkingLocationAuthorization(_ status : CLAuthorizationStatus) {
        switch status {
            
            /* the status Must be in this exact Order :
             in case (status notDetermined) and we clic on "Not Allow" in
             the premssion alert , we will go directly to
             the next case (status denied, restricted)
             and call showLocationPermisisonAlert().
             
             otherwise (status authorizedAlways, authorizedWhenInUse)
             we will call LocationManager().initLocationServices()
             */
            
        case .notDetermined:
            print("Authorization : notDetermined")
            // For IOS 14 use requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied, .restricted:
            print("Authorization : denied")
            delegate?.showUpdateLocationSettingsAlert()
            break
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorization : authorizedAlways / Authorization : authorizedWhenInUse")
            initLocationServices()
            print("User gave permissions for location")
            break
        @unknown default:
            print("Authorization: @unknown")
            break
            
        }
    }
    
}
