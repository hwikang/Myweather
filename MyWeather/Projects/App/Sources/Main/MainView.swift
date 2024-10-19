//
//  MainView.swift
//  MyWeather
//
//  Created by hwikang on 10/16/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import SwiftUI
import Network

public struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
   public var body: some View {
       
       
       if let data = viewModel.weatherData {
           ZStack {
//               Color.teal.edgesIgnoringSafeArea(.all)
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
                   ScrollView(.horizontal) {
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
                   
               }
           }
       } else {
           Text("Loading...")
       }
   }
    
    
    
    
}

#Preview {
    MainView(viewModel: MainViewModel(repository: WeatherRepository(network: WeatherNetwork(manager: NetworkManager()))))
}
