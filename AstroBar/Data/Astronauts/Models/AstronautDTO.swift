//
//  AstronautDTO.swift
//  AstroBar
//
//  Created by Jakub Tomana on 18/10/2025.
//

struct AstronautDTO: Codable {
    let name: String
    let spacecraft: String
}

extension AstronautDTO {
    func toDomain() -> Astronaut {
        Astronaut(name: name, craft: spacecraft)
    }
}
