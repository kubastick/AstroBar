//
//  MockAstronautsRepository.swift
//  AstroBar
//
//  Created by Jakub Tomana on 18/10/2025.
//

class MockAstronautsRepository: AstronautsRepository {
    private let testAstronauts = [
        Astronaut(name: "John Smith", craft: "ISS"),
        Astronaut(name: "123", craft: "abc"),
    ]

    func fetchAstronauts() async throws -> [Astronaut] {
        return testAstronauts
    }
}
