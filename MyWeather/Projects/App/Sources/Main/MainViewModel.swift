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
import Combine

final public class MainViewModel: ObservableObject {
    private let repository: WeatherRepository
    let selectedCoordinator = CurrentValueSubject<Coordinator, Never>(Coordinator(lon: 127.004173, lat: 36.783611))
    @Published var weatherData: WeatherResult?
    @Published var error: NetworkError?
    
    private var cancellable = Set<AnyCancellable>()
    public init(repository: WeatherRepository) {
        self.repository = repository
        binding()
    }
    
    private func binding() {
        selectedCoordinator.sink { [weak self] coordinator in
            self?.weatherData = nil
            self?.fetchWeather(lat: coordinator.lat, lon: coordinator.lon)
        }.store(in: &cancellable)
    }
    
    public func fetchWeather(lat: Double, lon: Double) {
        Task {
            let network = WeatherNetwork(manager: NetworkManager())
            let result = await network.fetchWeather(lat: lat, lon: lon)
            switch result {
            case .success(let weather):
                weatherData = weather
               
            case .failure(let error):
                self.error = error
            }
        }
    }
}

