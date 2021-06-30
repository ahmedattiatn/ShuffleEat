//
//  Response.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 13/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//


struct RestaurantsResponse: Decodable {
    var restaurant: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurant = "results"
    }
}
