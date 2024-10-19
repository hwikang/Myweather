//
//  Model.swift
//  Entity
//
//  Created by hwikang on 10/15/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

public struct WeatherResult: Decodable {
    public let timezone: String
    public let lat: Double
    public let lon: Double
    public let currentWeather: CurrentWeather

    public let hourlyWeathers: [HourlyWeather]
    public let dailyWeathers: [DailyWeather]
    
    enum CodingKeys: CodingKey {
        case lat
        case lon
        case current
        case hourly
        case daily
        case timezone
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.currentWeather = try container.decode(CurrentWeather.self, forKey: .current)
        let dailyWeathers = try container.decode([DailyWeather].self, forKey: .daily)
        self.dailyWeathers = Array(dailyWeathers.prefix(5))
        let hourlyWeathers = try container.decode([HourlyWeather].self, forKey: .hourly)
        self.hourlyWeathers = hourlyWeathers.enumerated().filter { index, _ in
            return index % 3 == 0
        }.map { $0.element }

    }
}

public struct CurrentWeather: Decodable {
    public let dt: Int
    public let temp: Double
    public let humidity: Int
    public let clouds: Int
    public let windSpeed: Double
    public let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case humidity
        case clouds
        case windSpeed = "wind_speed"
        case weather
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weather = try container.decode([Weather].self, forKey: .weather)
    }
}

public struct HourlyWeather: Decodable {
    
    public let dt: Int
    public let temp: Double
    public let weather: [Weather]
}
public struct DailyWeather: Decodable {
    public let dt: Int
    public let dayTemp: Double
    public let minTemp: Double
    public let maxTemp: Double
    public let weather: [Weather]
    
    enum CodingKeys: CodingKey {
        case dt
        case temp
        case weather
    }
    
    enum TempCodingKey: CodingKey {
        case min
        case max
        case day
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        let tempContainer = try container.nestedContainer(keyedBy: TempCodingKey.self, forKey: .temp)
        self.dayTemp = try tempContainer.decode(Double.self, forKey: .day)
        self.minTemp = try tempContainer.decode(Double.self, forKey: .min)
        self.maxTemp = try tempContainer.decode(Double.self, forKey: .max)
        self.weather = try container.decode([Weather].self, forKey: .weather)
    }
}

public struct Weather: Decodable {
    public let id: Int
    public let description: String
    public let icon : String
}
