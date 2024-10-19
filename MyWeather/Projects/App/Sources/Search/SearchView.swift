//
//  SearchView.swift
//  MyWeather
//
//  Created by hwikang on 10/18/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import SwiftUI
import Entity
import Combine

struct SearchView: View {
    var selectedCoordinator:  CurrentValueSubject<Coordinator, Never>

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchView(selectedCoordinator: CurrentValueSubject<Coordinator, Never>(Coordinator(lon: 0, lat: 0  )))
}
