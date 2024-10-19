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
    
    public func fetchDutchResult(lat: Decimal, lon: Decimal) async -> Result<WeatherResult, NetworkError> {
//        guard let apiKey = Bundle.main.apiKey else { return .failure(.requestFailed("API Key nil"))}

        let parameter: Parameters = [
            "units": "metric",
            "lat": lat,
            "lon": lon,
            "appid": "9425bdaf5f7788acd3228ca29c0da276"
        ]
        return await manager.fetchData(url: baseURL, method: .get, parameters: parameter)
        
    }
    
}
