//
//  JsonResConst.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 13/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import Foundation

// MARK: - CellID
struct Constants {
    enum ConstCellID: String {
        case restaurantsCell = "RestaurantsCell"
        case preferenceCell = "PreferenceCell"
        case RestaurantsListTableViewCell = "RestaurantsListTableViewCell"
    }
    
    enum UserDefaults: String {
        case launchedBefore = "launchedBefore"
        case notificationTime = "notificationTime"
        case notificationActivated = "notifActivated"
        case onBoardingShown =  "onboardingWasShown"
        case timeNotif =  "timeNotif"
        case favoritePreferenceOfTheDay = "FavoritePreferenceOfTheDay"
        case favoritePreferences = "FavoritePreferences"
    }
    
    enum IBDesignable: CGFloat {
        case radius = 10
    }
    
    // MARK: - LinksID
    enum ConstBasicLink : String {
        //Base Link For Debug
        case nearbySearch = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        case showMainPhoto = "https://maps.googleapis.com/maps/api/place/photo?"
        //In case we have more than one Target we put here the basic link for release or staging...
    }
    
    
    
    enum dimensions: CGFloat {
        case tableViewCellHeight  = 175
    }
}
