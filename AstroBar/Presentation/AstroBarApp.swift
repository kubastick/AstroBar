//
//  AstroBarApp.swift
//  AstroBar
//
//  Created by Jakub Tomana on 16/10/2025.
//

import SwiftUI

@main
struct AstroBarApp: App {
    @State private var viewModel: AstronautListViewModel

    init() {
        let viewModel = AstronautListViewModel(repository: AstronautsRepositoryImpl())
        self.viewModel = viewModel

        Task {
            await viewModel.fetchAstronauts()
            await viewModel.periodicallyRefreshAstronautList()
        }
    }

    var body: some Scene {
        MenuBarExtra {
            AstronautListFeature(viewModel: viewModel)
        } label: {
            MenuBarLabel(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)
    }
}

struct MenuBarLabel: View {
    let viewModel: AstronautListViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Image(systemName: "globe.americas.fill")
            switch viewModel.astronauts {
            case .loading:
                Text("...")
            case .loaded(let astronauts):
                Text("\(astronauts.count)")
            case .failed:
                Text("!")
            }
        }.font(.subheadline)
    }
}
