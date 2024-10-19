//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hwikang on 10/15/24.
//

import Foundation
import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [:]

let project = Project(name: "Entity",
                      organizationName: "HwiKang",
                      targets: [
                        Target(name: "Entity", platform: .iOS, product: .framework, bundleId: "simon.kang.myweather.entity",
                               deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
                               infoPlist: .extendingDefault(with: infoPlist),
                               sources: ["Sources/**"],
                               dependencies: [
                                    
                               ]
                              )
                      ])
