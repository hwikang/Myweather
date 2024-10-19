//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hwikang on 10/15/24.
//

import Foundation
import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [:]

let project = Project(name: "Network",
                      organizationName: "HwiKang",
                      targets: [
                        Target(name: "Network", platform: .iOS, product: .framework, bundleId: "simon.kang.myweather",
                               infoPlist: .extendingDefault(with: infoPlist),
                               sources: ["Sources/**"],
                               dependencies: [
                                .external(name: "Alamofire")
                               ]
                              )
                      ])
