//
//  Astronaut.swift
//  AstroBar
//
//  Created by Jakub Tomana on 16/10/2025.
//

struct Astronaut: Identifiable, Codable {
    let name: String
    let craft: String

    // TODO: Using name as a ID probably won't be an issue in the upcoming decades
    var id: String {
        name
    }
}
