//
//  MainViewModel.swift
//  MyWeather
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation
import Network
import Entity

final public class MainViewModel: ObservableObject {
    private let repository: WeatherRepository
    @Published var weatherData: WeatherResult?
    public init(repository: WeatherRepository) {
        self.repository = repository
        fetchWeather(lat: 36.783611, lon: 127.004173)
    }
    
    public func fetchWeather(lat: Double, lon: Double) {
        Task {
            let network = WeatherNetwork(manager: NetworkManager())
            let result = await network.fetchWeather(lat: lat, lon: lon)
            switch result {
            case .success(let weather):
                print(weather)
                Task { @MainActor in
                    weatherData = weather
                }
               
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func trimHourlyWeather() {
        
    }
}

