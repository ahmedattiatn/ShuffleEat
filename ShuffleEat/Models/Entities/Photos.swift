//
//  Photos.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 09/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

struct Photo {
    var references: String
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case references = "photo_reference"
        case width
    }
}

extension Photo: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        references = try values.decode(String.self, forKey: .references)
        width = try values.decode(Int.self, forKey: .width)
    }
}
