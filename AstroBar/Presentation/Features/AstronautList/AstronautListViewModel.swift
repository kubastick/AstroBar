//
//  AstronautListViewModel.swift
//  AstroBar
//
//  ViewModel for managing astronaut data state
//

import Foundation

@Observable
final class AstronautListViewModel {
    private let repository: AstronautsRepository
    private let periodicRefreshInterval: Duration = .seconds(60 * 60 * 12) // 12 hours

    init(repository: AstronautsRepository) {
        self.repository = repository
    }

    var astronauts: AstronautListState = .loading

    @MainActor
    func fetchAstronauts() async {
        astronauts = .loading

        await refresh()
    }

    @MainActor
    func refresh() async {
        print("refresh")
        do {
            astronauts = try .loaded(await repository.fetchAstronauts())
        } catch {
            astronauts = .failed(error.localizedDescription)
        }
    }

    @MainActor
    func periodicallyRefreshAstronautList() async {
        do {
            while true {
                try await Task.sleep(for: periodicRefreshInterval)
                await refresh()
            }
        } catch {}
    }
}

extension AstronautListViewModel {
    enum AstronautListState {
        case loading
        case loaded([Astronaut])
        case failed(String)
    }
}
