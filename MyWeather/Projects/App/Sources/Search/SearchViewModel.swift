//
//  SearchViewModel.swift
//  MyWeather
//
//  Created by hwikang on 10/18/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//
import Foundation
import Network
import Entity
import Combine

final public class SearchViewModel: ObservableObject {
    private let repository: WeatherRepository

    @Published var locations: [Location] = []
    private var cancellable = Set<AnyCancellable>()
    public init(repository: WeatherRepository) {
        self.repository = repository
        
    }
        
    public func getLocations() {
        
    }
}

