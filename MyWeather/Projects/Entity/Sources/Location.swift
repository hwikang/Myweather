//
//  Location.swift
//  Entity
//
//  Created by hwikang on 10/18/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

public struct Location: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let country: String
    public let coord: Coordinator
}

public struct Coordinator: Decodable {
    public init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    public let lon: Double
    public let lat: Double
}
