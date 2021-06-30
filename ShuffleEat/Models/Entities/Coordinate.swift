//
//  Coordinate.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 12/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//


struct Coordinate {
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}
