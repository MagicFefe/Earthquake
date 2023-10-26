//
//  QuakeLocation.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 25.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

struct QuakeLocation: Decodable {
    var latitude: Double { properties.products.origin.first!.properties.latitude }
    var longitude: Double { properties.products.origin.first!.properties.longitude }
    private var properties: RootProperties
    
    struct RootProperties: Decodable {
        var products: Products
    }
    
    struct Products: Decodable {
        var origin: [Origin]
    }
    
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    
    struct OriginProperties {
        var latitude: Double
        var longitude: Double
    }
    
    init(latitude: Double, longitude: Double) {
        self.properties = RootProperties(
            products: Products(
                origin: [Origin(
                    properties: OriginProperties(
                        latitude: latitude, longitude: longitude))
                ]))
    }
}

extension QuakeLocation.OriginProperties: Decodable {
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let originValues = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
        let rawLatitude = try originValues.decode(String.self, forKey: .latitude)
        let rawLongitude = try originValues.decode(String.self, forKey: .longitude)
        
        guard let latitude = Double(rawLatitude),
              let longitude = Double(rawLongitude) else { throw QuakeError.missingData }
        self.latitude = latitude
        self.longitude = longitude
    }
}
