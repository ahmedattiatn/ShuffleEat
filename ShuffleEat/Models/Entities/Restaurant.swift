//
//  Food.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

struct Restaurant  {
    var name: String
    var rating: Double
    var usersRating: Int
    var adresse: String
    var location: Coordinate
    var photosInfo : [Photo]?
    //make photosInfo optional or it will cause a "Unknown Problem" when parsing the values
    
    enum CodingKeys: String, CodingKey {
        case name
        case rating
        case geometry
        case location
        case usersRating = "user_ratings_total"
        case adresse = "vicinity"
        case photosInfo = "photos"
    }
}

extension Restaurant: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.adresse = try container.decode(String.self, forKey: .adresse)
        self.usersRating = try container.decode(Int.self, forKey: .usersRating)
        let geometry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        self.location = try geometry.decode(Coordinate.self, forKey: .location)
        self.photosInfo = try? container.decode([Photo].self, forKey: .photosInfo)
        
    }
}

