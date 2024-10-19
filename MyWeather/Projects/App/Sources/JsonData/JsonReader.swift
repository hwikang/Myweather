//
//  JsonReader.swift
//  Network
//
//  Created by hwikang on 10/18/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation

public struct JsonReader {
    static public func loadJSONFromFile<T: Decodable>(_ filename: String) -> [T]? {
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json"),
         let data = try? Data(contentsOf: file) else {
            return nil
        }
        let decodedData = try? JSONDecoder().decode([T].self, from: data)
        return decodedData
    }
}
