//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hwikang on 10/15/24.
//

import Foundation
import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [:]

let project = Project(
    name: "Network",
    organizationName: "HwiKang",
    targets: [
        Target(name: "Network",
               platform: .iOS, product: .framework,
               bundleId: "simon.kang.myweather.network",
               deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
               infoPlist: .extendingDefault(with: infoPlist),
               sources: ["Sources/**"],
               resources: ["Resources/**"],
               dependencies: [
                .external(name: "Alamofire"),
                .project(target: "Entity", path: "../Entity")
               ]
              )
    ])
