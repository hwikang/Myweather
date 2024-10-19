//
//  WeatherNetwork.swift
//  Network
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//


import Foundation
import Entity
import Alamofire

public struct WeatherNetwork {
    private let manager: NetworkManager
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall"
    public init(manager: NetworkManager) {
        self.manager = manager
    }
    
    public func fetchWeather(lat: Double, lon: Double) async -> Result<WeatherResult, NetworkError> {
        
        guard let apiKey = BundleManager.apiKey else { return .failure(.requestFailed("API Key nil"))}

        let parameter: Parameters = [
            "units": "metric",
            "lat": lat,
            "lon": lon,
            "appid": apiKey
        ]
        return await manager.fetchData(url: baseURL, method: .get, parameters: parameter)
        
    }
    
}
