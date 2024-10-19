//
//  MainView.swift
//  MyWeather
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import SwiftUI
import Network

struct MainView: View {
    init() {
        test()
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    public func test() {
        Task {
            let network = WeatherNetwork(manager: NetworkManager())
            let result = await network.fetchDutchResult(lat: 36.783611, lon: 127.004173)
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    MainView()
}
