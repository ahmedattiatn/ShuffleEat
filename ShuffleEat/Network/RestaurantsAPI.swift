//
//  MyPersonalAPI.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import Combine

class RestaurantsAPI: NSObject {
    let agent = Agent()
    var myApiKey : String?
    lazy var prefChoice = PreferenceViewModel().getFavoritePreferences()
    
    override init() {
        super.init()
        guard let key = Bundle.main.infoDictionary?["MyKeyAPI"] as? String else {
            return
        }
        self.myApiKey = key
    }
    
    func buildUrl(_ latiude:Double, _ longitude:Double) -> String{
        return Constants.ConstBasicLink.nearbySearch.rawValue
            + "location=\(latiude),\(longitude)&"
            + "type=restaurant&"
            + "keyword=\(prefChoice)&"
            + "opennow&"
            + "rankby=distance&" //rankby must not be included if radius is included
            + "key=\(myApiKey ?? "")"
    }
}

extension RestaurantsAPI {
    func getRestaurants(_ latiude:Double, _ longitude:Double) -> AnyPublisher<RestaurantsResponse, Error> {
        
        let url = URL(string: buildUrl(latiude, longitude))
        print("Google Places url : ",buildUrl(latiude, longitude))
        return run(URLRequest(url: url!))
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}

/*
 //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.8662109375,2.2199235802917094&radius=5000&type=restaurant&keyword=pizza&opennow&key=AIzaSyCFgIIfIM9oRE5fCF02pFiLiScMjJrUKwc
 
 imageUrl -> https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=' + PHOTO_REFERENCE + '&key=' + API_KEY
 
 https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAA7ac1LPqjHrnPDwczMdgC-QtrylAFNzBPqF43NAAv5BGyYb9djDzKoEBR_7z1WXR1QhanQXniu_NH9W6rURaUNnkjAbKbJFd2wOhfXNWeAp1c-HPV3JentrsOLuU7TE7kEhBQjuKUvCFM7HcC6JGI9FlaGhS8p7LS0m3S4qniv8MNEVe0K9Oxmw&key=AIzaSyCFgIIfIM9oRE5fCF02pFiLiScMjJrUKwc
 
 */
