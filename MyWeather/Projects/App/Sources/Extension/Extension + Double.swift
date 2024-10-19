//
//  Extension + Double.swift
//  MyWeather
//
//  Created by hwikang on 10/17/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

extension Double {
    func tempFormatted() -> String {
        "\(self.rounded())°"
    }
}
