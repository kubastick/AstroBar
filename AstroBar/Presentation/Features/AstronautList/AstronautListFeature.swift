//
//  AstronautListFeature.swift
//  AstroBar
//
//  Created by Jakub Tomana on 16/10/2025.
//

import SwiftUI

struct AstronautListFeature: View {
    @Environment(\.openURL) private var openURL

    let viewModel: AstronautListViewModel

    @State private var sortOrder = [KeyPathComparator(\Astronaut.name)]

    var body: some View {
        VStack {
            switch viewModel.astronauts {
            case .loading:
                LoadingView()
            case .failed(let message):
                ErrorView(message: message) {
                    Task {
                        await viewModel.fetchAstronauts()
                    }
                }
            case .loaded(let astronauts):
                Text("Currently there are \(astronauts.count) astronauts in space.")
                    .font(.headline)
                    .padding(.bottom, 8)

                Table(astronauts.sorted(using: sortOrder), sortOrder: $sortOrder) {
                    TableColumn("Name", value: \.name)
                    TableColumn("Spacecraft", value: \.craft)
                }
            }

            HStack {
                Text("AstroBar 🚀")
                    .font(.footnote)
                    .onTapGesture {
                        if let url = URL(string: "https://github.com/kubastick/AstroBar") {
                            openURL(url)
                        }
                    }
                    .pointerStyle(.link)
                    .underline()
                Spacer()
                Button("Exit app") {
                    NSApplication.shared.terminate(nil)
                }
                .controlSize(.small)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .scaleEffect(1.2)
            Text("Fetching astronauts...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)

            Text("Oops!")
                .font(.title2)
                .fontWeight(.semibold)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: onRetry) {
                Label("Retry", systemImage: "arrow.clockwise")
            }
            .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    let mockRepository = MockAstronautsRepository()
    let viewModel = AstronautListViewModel(repository: mockRepository)
    return AstronautListFeature(viewModel: viewModel)
}
