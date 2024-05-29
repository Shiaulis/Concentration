//
//  Concentration.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 28.05.2024.
//

import Foundation

final class Concentration {

    typealias CardIndex = Array<Card>.Index

    // MARK: - Properties -

    var cards: [Card] = []

    private var indexOfOneAndOnlyFaceUpCard: CardIndex?

    // MARK: - Init -

    init(numberOfPairsOfCards: Int ) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }
    }

    // MARK: - Public API -

    func chooseCard(at chosenIndex: CardIndex) {
        guard !self.cards[chosenIndex].isMatched else {
            return
        }

        if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != chosenIndex {
            if isMatching(at: [chosenIndex, matchIndex]) {
                markAsMatched(at: [chosenIndex, matchIndex])
            }

            faceUp(at: chosenIndex)
        }
        else {
            faceDownAll()
            faceUp(at: chosenIndex)
        }
    }

    // MARK: - Private API -

    private func isMatching(at indices: [CardIndex]) -> Bool {
        let cards = indices.map { self.cards[$0] }
        guard let first = cards.first else {
            return true
        }

        return cards.allSatisfy { $0.id == first.id }
    }

    private func markAsMatched(at indices: [CardIndex]) {
        indices.forEach { self.cards[$0].isMatched = true }
    }

    private func faceUp(at index: CardIndex) {
        self.cards[index].isFaceUp = true

        if self.indexOfOneAndOnlyFaceUpCard != nil {
            self.indexOfOneAndOnlyFaceUpCard = nil
        }
        else {
            self.indexOfOneAndOnlyFaceUpCard = index
        }
    }

    private func faceDownAll() {
        self.cards.indices.forEach { self.cards[$0].isFaceUp = false }
    }

}
