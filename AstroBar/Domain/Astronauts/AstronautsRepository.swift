//
//  AstrounautsRepository.swift
//  AstroBar
//
//  Created by Jakub Tomana on 18/10/2025.
//

protocol AstronautsRepository {
    func fetchAstronauts() async throws -> [Astronaut]
}
