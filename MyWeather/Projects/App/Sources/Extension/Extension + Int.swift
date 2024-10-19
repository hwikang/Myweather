//
//  Extension + Int.swift
//  MyWeather
//
//  Created by hwikang on 10/17/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation
extension Int {
    func koranHourFormatted() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h시"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let formattedTime = dateFormatter.string(from: date)
        return formattedTime
    }
    func koranDayFormatted() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        let formattedWeekday = dateFormatter.string(from: date)
        return formattedWeekday
    }
}
