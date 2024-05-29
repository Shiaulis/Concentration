//
//  Card.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 28.05.2024.
//

import Foundation

struct Card: Identifiable {

    // MARK: - Properties -

    var isFaceUp = false
    var isMatched = false
    var id: Int

    // MARK: - Init -

    init() {
        self.id = Self.getUniqueIdentifier()
    }

}

// MARK: - Identifiers Factory -

extension Card {

    static var identifierFactory = 0

    static func getUniqueIdentifier() -> Int {
        Self.identifierFactory += 1
        return Self.identifierFactory
    }

}
