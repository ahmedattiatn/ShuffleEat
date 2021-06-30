//
//  RestaurantViewModel.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 18/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import Combine

class RestaurantViewModel {
    
    var delegate:RestaurantViewModelProtocol? = nil
    var restaurantArray : [Restaurant] = []
    var randomRestaurant:Restaurant?
    let locationManager = LocationManager()
    
    private var cancellable: AnyCancellable?
    
    func distanceInMetersFrom(_ restaurantLocation: Coordinate)-> Double {
        return locationManager.distanceFrom(location: restaurantLocation)
    }
    
    func openMapAndShow(_ restaurant:Restaurant) {
        if let url = URL(string: "\(buildMapUrl(restaurant))"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                if (!success) {
                    print("error: failed to open Map")
                    self.delegate?.showMapErrorAlert()
                }
            })
        }
    }
    
    func buildMapUrl(_ restaurant:Restaurant)-> String {
        let name = restaurant.name.replacingOccurrences(of: " ", with: "+")
        return "comgooglemaps://?q=\(name)&center=\(restaurant.location.latitude),\(restaurant.location.longitude)&views=satellite,traffic&zoom=17"
        
    }
    
    func buildPhotoUrl(_ photoInfo:Photo)-> String? {
        var url : String?
        // maxwidth must be = 500 and not photoInfo.width or we won't see the photo because it's very large
        // (some times the value of photoInfo.width is 1000 or above )
        if let apiKey = RestaurantsAPI().myApiKey {
            url = "\(Constants.ConstBasicLink.showMainPhoto.rawValue)maxwidth=\(500)&photoreference=\(photoInfo.references)&key=\(apiKey)"
        }
        return url
    }
    
    func getNearByRestaurants() {
        restaurantArray.removeAll()
        let current = locationManager.getCurrentLocation()
        let sharedApi = RestaurantsAPI()
        self.cancellable = sharedApi.getRestaurants(current.latitude, current.longitude)
            .sink(receiveCompletion: { completion in
                //4
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.delegate?.handleError(error: error)
                }
            },
                  receiveValue: {
                    decodeResponse in
                    print("\n***********************************************\n", decodeResponse)
                    self.restaurantArray = decodeResponse.restaurant
                    self.randomRestaurant = self.restaurantArray.randomElement()
                    self.delegate?.restaurantListReturned()
            })
    }
}
