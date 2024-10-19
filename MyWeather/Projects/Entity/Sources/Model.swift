//
//  Model.swift
//  Entity
//
//  Created by hwikang on 10/15/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

public struct WeatherResult: Decodable {
    let name: String
    let temp: Double
    let description: String
    let lat: Double
    let lon: Double
    let humidity: Int
    let clouds: Int
    let windSpeed: Double
    let hourlyTemps: [Double]
    let dailyWeathers: [DailyWeather]

}

public struct HourlyWeather: Decodable {
    let dt: Int
    let temp: Double
    let weather: Weather
}
public struct DailyWeather: Decodable{
    let dt: Int
    let minTemp: Double
    let maxTemp: Double
    let weather: Weather
}

public struct Weather: Decodable{
    let id: Int
    let description: String
    let icon : String
}
