//
//  MainView.swift
//  MyWeather
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import SwiftUI
import Network
import MapKit

public struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        

       if let data = viewModel.weatherData {
           ZStack {
               ScrollView(.vertical, showsIndicators: true) {
                   VStack {
                       HStack {
                           Text("Search")
                           Spacer()
                       }
                       .frame(height: 44)
                       .background(Color.gray)
                       VStack {
                           if let firstDayWeatehr = data.dailyWeathers.first, let firstDayWeatherDetail = firstDayWeatehr.weather.first {
                               Text(data.timezone)
                               Text(firstDayWeatehr.dayTemp.tempFormatted())
                               Text(firstDayWeatherDetail.description)
                               Text("최고: \(firstDayWeatehr.maxTemp.tempFormatted()) 최저: \(firstDayWeatehr.minTemp.tempFormatted())")
                               
                           }
                       }
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(data.hourlyWeathers, id: \.dt) { item in
                                   
                                   VStack{
                                       Text(item.dt.koranHourFormatted())
                                       if let icon = item.weather.first?.icon.prefix(2) {
                                           Image("\(String(icon))d")
                                       }
                                       
                                       Text(item.temp.tempFormatted())
                                   }
                               }
                           }
                       }
                       ForEach(data.dailyWeathers, id: \.dt) { item in
                           HStack {
                               Text(item.dt.koranDayFormatted())
                               if let icon = item.weather.first?.icon.prefix(2) {
                                   Image("\(String(icon))d")
                               }
                               Text(item.minTemp.tempFormatted())
                               Text(item.maxTemp.tempFormatted())
                           }
                       }
                       MapView(coordinate: .init(latitude: data.lat, longitude: data.lon))
                           .frame(maxWidth: .infinity, minHeight: 300)
                           .cornerRadius(10)
                           .padding(16)
                        
                       HStack {
                           
                       }
                       Spacer()
                       
                   }
               }.frame(maxWidth: .infinity, maxHeight: .infinity)
           }
       } else {
           Text("Loading...")
       }
   }
}

struct WeatherContainerView: View {
   
    private let title: String
    private let value: String
    
    public var body: some View {
        ZStack {
            Color.blue
            HStack {
                Text(title)
                    .font(.caption)
                    .padding(.leading, 8)
                Text(value)
                    .font(.title2)
            }
        }.cornerRadius(10)
    }
}



#Preview {
    MainView(viewModel: MainViewModel(repository: WeatherRepository(network: WeatherNetwork(manager: NetworkManager()))))
}
