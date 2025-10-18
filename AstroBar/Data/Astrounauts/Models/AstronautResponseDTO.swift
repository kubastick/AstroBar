//
//  AstronautResponseDTO.swift
//  AstroBar
//
//  Created by Jakub Tomana on 18/10/2025.
//

struct AstronautResponseDTO: Codable {
    let people: [AstronautDTO]
}

extension AstronautResponseDTO {
    func toDomain() -> [Astronaut] {
        people.map { $0.toDomain() }
    }
}
