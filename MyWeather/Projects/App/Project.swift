//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hwikang on 10/15/24.
//

import Foundation
import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [:]

let project = Project(name: "MyWeather",
                      organizationName: "HwiKang",
                      targets: [
                        Target(name: "MyWeather", platform: .iOS, product: .app, bundleId: "simon.kang.myweather",
                               infoPlist: .extendingDefault(with: infoPlist),
                               sources: ["Sources/**"],
                               resources: ["Resources/**"],
                               dependencies: [
                                .project(target: "Network", path: "../Network"),
                                .project(target: "Entity", path: "../Entity"),
                               ]
                              )
                      ]
)
