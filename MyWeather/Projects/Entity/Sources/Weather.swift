//
//  Model.swift
//  Entity
//
//  Created by hwikang on 10/15/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

public struct WeatherResult: Decodable {
//    let name: String
    let temp: Double
    let weather: [Weather]
    let lat: Double
    let lon: Double
    let humidity: Int
    let clouds: Int
    let windSpeed: Double
    let hourlyTemps: [HourlyWeather]
    let dailyWeathers: [DailyWeather]
    
    enum CodingKeys: CodingKey {
        case lat
        case lon
        case current
        case hourly
        case daily
    }
    enum CurrentCodingKeys: String, CodingKey {
        case temp
        case humidity
        case clouds
        case windSpeed = "wind_speed"
        case weather
    }
   
    enum WeatherCodingKeys: CodingKey {
        case id
        case description
        case icon
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
        
        let currentContainer = try container.nestedContainer(keyedBy: CurrentCodingKeys.self, forKey: CodingKeys.current)
        self.temp = try currentContainer.decode(Double.self, forKey: .temp)
        self.humidity = try currentContainer.decode(Int.self, forKey: .humidity)
        self.clouds = try currentContainer.decode(Int.self, forKey: .clouds)
        self.windSpeed = try currentContainer.decode(Double.self, forKey: .windSpeed)
        self.weather = try currentContainer.decode([Weather].self, forKey: .weather)
        self.hourlyTemps = try container.decode([HourlyWeather].self, forKey: .hourly)
        self.dailyWeathers = try container.decode([DailyWeather].self, forKey: .daily)
    }

}

public struct HourlyWeather: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}
public struct DailyWeather: Decodable {
    let dt: Int
    let minTemp: Double
    let maxTemp: Double
    let weather: [Weather]
    
    enum CodingKeys: CodingKey {
        case dt
        case temp
        case weather
    }
    
    enum TempCodingKey: CodingKey {
        case min
        case max
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        let tempContainer = try container.nestedContainer(keyedBy: TempCodingKey.self, forKey: .temp)
        self.minTemp = try tempContainer.decode(Double.self, forKey: .min)
        self.maxTemp = try tempContainer.decode(Double.self, forKey: .max)
        self.weather = try container.decode([Weather].self, forKey: .weather)
    }
}

public struct Weather: Decodable{
    let id: Int
    let description: String
    let icon : String
}
