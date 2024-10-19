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

    @Published var locations: [Location] = []
    @Published var searchedLocations: [Location] = []
    @Published var query: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    public init() {
        getLocations()
        binding()
    }

    public func getLocations() {
        let location: [Location] = JsonReader.loadJSONFromFile("citylist") ?? []
        self.locations = location
        self.searchedLocations = location
    }
    
    private func binding() {
        
        $query
            .filter{ !$0.isEmpty }
            .map { $0.lowercased() }
            .sink { [weak self] query in
            self?.searchLocation(query: query)
        }.store(in: &cancellable)
    }
    
    private func searchLocation(query: String) {
        let searchedLocations = locations.filter { $0.name.lowercased().contains(query) || $0.country.lowercased().contains(query) }
        self.searchedLocations = searchedLocations
    }
    
    
}

