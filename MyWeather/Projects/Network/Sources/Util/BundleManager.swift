//
//  Extension + Bundle.swift
//  Watcha
//
//  Created by hwikang on 10/11/24.
//

import Foundation

class BundleManager {
    static var apiKey: String? {
        let bundle = Bundle(for: BundleManager.self)
        guard let file = bundle.path(forResource: "Secret", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["APIKEY"] as? String else {
            print("API KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        
        return key
    }
}
