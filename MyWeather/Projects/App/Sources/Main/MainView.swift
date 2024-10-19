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
import Entity

public struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    @State private var presentSearchView: Bool = false
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
       if let data = viewModel.weatherData {
           ZStack {
               ScrollView(.vertical, showsIndicators: true) {
                   VStack {
                       SearchButton(presentSearchView: $presentSearchView)
                       CurrentWeatherView(data: data)
                       HourlyWeatherView(hourlyWeathers: data.hourlyWeathers)
                       DailyWeatherView(dailyWeathers: data.dailyWeathers)
                     
                       MapView(coordinate: .init(latitude: data.lat, longitude: data.lon))
                           .frame(maxWidth: .infinity, minHeight: 300)
                           .cornerRadius(10)
                           .padding(16)
                        
                       Grid {
                           GridRow {
                               WeatherContainerView(title: "습도", value: "\(data.currentWeather.humidity)%")
                               WeatherContainerView(title: "구름", value: "\(data.currentWeather.clouds)%")
                           }
                           GridRow {
                               WeatherContainerView(title: "바람 속도", value: "\(data.currentWeather.windSpeed)m/s")
                               
                           }
                       }.padding(16)
                       
                   }
               }.frame(maxWidth: .infinity, maxHeight: .infinity)
                   .fullScreenCover(isPresented: $presentSearchView, content: {
                       SearchView(viewModel: SearchViewModel(), selectedCoordinator: viewModel.selectedCoordinator)
                   })
           }
       } else {
           Text("Loading...")
       }
   }
    
}

struct SearchButton: View {
    @Binding var presentSearchView: Bool

    var body: some View {
        Button(action: {
            presentSearchView = true
        }, label: {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search")
                Spacer()
            }
        })
        .foregroundStyle(.gray)
        .frame(height: 44)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(16)
    }
}

struct CurrentWeatherView: View {
    let data: WeatherResult

    var body: some View {
        VStack {
            if let firstDayWeather = data.dailyWeathers.first, let firstDayWeatherDetail = firstDayWeather.weather.first {
                Text(data.timezone)
                Text(firstDayWeather.dayTemp.tempFormatted())
                    .font(.title)
                    .fontWeight(.bold)
                Text(firstDayWeatherDetail.description)
                    .font(.subheadline)
                Text("최고: \(firstDayWeather.maxTemp.tempFormatted()) 최저: \(firstDayWeather.minTemp.tempFormatted())")
            }
        }
    }
}

struct HourlyWeatherView: View {
    let hourlyWeathers: [HourlyWeather]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(hourlyWeathers, id: \.dt) { item in
                    VStack {
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
struct DailyWeatherView: View {
    let dailyWeathers: [DailyWeather]

    var body: some View {
        ForEach(dailyWeathers, id: \.dt) { item in
            HStack {
                Text(item.dt.koranDayFormatted())
                if let icon = item.weather.first?.icon.prefix(2) {
                    Image("\(String(icon))d")
                }
                Text("최저: \(item.minTemp.tempFormatted())")
                Text("최고: \(item.maxTemp.tempFormatted())")
            }
        }
    }
}

struct WeatherContainerView: View {
    
    let title: String
    let value: String
    
    public var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text(title)
                    .font(.caption)
                Text(value)
                    .font(.title2)
            }
            .frame(height: 150)
        }.cornerRadius(10)
    }
}



#Preview {
    MainView(viewModel: MainViewModel(repository: WeatherRepository(network: WeatherNetwork(manager: NetworkManager()))))
}
