//
//  Dependencies.swift
//  Config
//
//  Created by hwikang on 10/15/24.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies( [
    .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.9.0"))

])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)

