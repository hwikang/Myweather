//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hwikang on 10/15/24.
//

import Foundation
import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [
           "UILaunchBackgroundColor": "#FFFFFF",  // 배경색 설정
       ]
]

let project = Project(name: "MyWeather",
                      organizationName: "HwiKang",
                      targets: [
                        Target(name: "MyWeather", platform: .iOS, product: .app, bundleId: "simon.kang.myweather",
                               deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
                               infoPlist: .extendingDefault(with: infoPlist),
//                               infoPlist: .file(path: "Info.plist"),
                               sources: ["Sources/**"],
                               resources: ["Resources/**"],
                               dependencies: [
                                .project(target: "Network", path: "../Network"),
                                .project(target: "Entity", path: "../Entity"),
                               ]
                              )
                      ]
)
