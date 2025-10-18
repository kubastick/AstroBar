//
//  AstronautsRepositoryImpl.swift
//  AstroBar
//
//  Created by Jakub Tomana on 18/10/2025.
//

import Foundation

class AstronautsRepositoryImpl : AstronautsRepository {
    private let apiUrl = "https://corquaid.github.io/international-space-station-APIs/JSON/people-in-space.json"
    
    func fetchAstronauts() async throws -> [Astronaut] {
        guard let url = URL(string: apiUrl) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(AstronautResponseDTO.self, from: data)
        
        return response.toDomain()
    }
    
    
}
