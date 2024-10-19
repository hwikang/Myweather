//
//  WeatherRepository.swift
//  Network
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation
import Entity

public struct WeatherRepository {
    private let network: WeatherNetwork
    public init(network: WeatherNetwork) {
        self.network = network
    }
    
    public func fetchWeather(lat: Double, lon: Double) async -> Result<WeatherResult, NetworkError> {
        await network.fetchWeather(lat: lat, lon: lon)
    }
  
}
