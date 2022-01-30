//
//  City.swift
//  BackbaseCitySearch
//
//  Created by alaattinbulut on 30.01.2022.
//

import Foundation

struct City {
    var country: String
    var name: String
    var id: Int
    var coordinate: Coordinate
}

extension City: Decodable {
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinate = "coord"
    }
}

struct Coordinate {
    var latitude: Double?
    var longitude: Double?
}

extension Coordinate: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
