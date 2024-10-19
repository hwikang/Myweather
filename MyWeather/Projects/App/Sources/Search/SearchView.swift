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
import Network

public struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: SearchViewModel
    var selectedCoordinator: CurrentValueSubject<Coordinator, Never>
    public init(viewModel: SearchViewModel, selectedCoordinator: CurrentValueSubject<Coordinator, Never>) {
        self.viewModel = viewModel
        self.selectedCoordinator = selectedCoordinator
    }
    
    public var body: some View {
        VStack {
            TextField("Search", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding(16)
            List(viewModel.searchedLocations) { location in
               
                Button {
                    selectedCoordinator.send(location.coord)
                    dismiss()
                    
                } label: {
                    VStack(alignment: .leading) {
                        Text(location.name)
                            .font(.title2)
                        
                        Text(location.country)
                            .font(.subheadline)
                    }
                    .foregroundStyle(Color.primary)
                }


            }
            
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(),
               selectedCoordinator: CurrentValueSubject<Coordinator, Never>(Coordinator(lon: 0, lat: 0)))
}
