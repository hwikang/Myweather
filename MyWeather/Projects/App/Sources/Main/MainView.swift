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
               Color.teal.edgesIgnoringSafeArea(.all)
               VStack {
                   HStack {
                       Text("Search")
                       Spacer()
                   }
                   .frame(height: 44)
                   .background(Color.gray)
                   VStack {
                       
                       Text("\(Int(data.temp.rounded()))")
                       Text(data.weather.first?.description ?? "")
                       
                   }
                   ScrollView(.horizontal) {
                       HStack {
                           ForEach(data.hourlyWeathers, id: \.dt) { item in
                               
                               VStack{
                                   if let icon = item.weather.first?.icon.prefix(2) {
                                       Image("\(String(icon))d")
                                   }
                                 
                                   Text("\(Int(item.temp.rounded()))")
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
