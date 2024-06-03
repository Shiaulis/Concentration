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
    private var emojiChoices: [String]
    private var emoji = [Int: String]()

    private var indexOfOneAndOnlyFaceUpCard: CardIndex?

    // MARK: - Init -

    init(numberOfCards: Int, theme: ConcentrationTheme) {
        self.emojiChoices = theme.getEmojis()
        let numberOfPairsOfCards = (numberOfCards + 1) / 2

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            self.cards += [card, card]
        }

        self.cards.shuffle()
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
        }
        else {
            turnFaceDownAll()
        }

        turnFaceUp(at: chosenIndex)
    }

    func generateEmoji(for card: Card) -> String {
        if self.emoji[card.id] == nil, !self.emojiChoices.isEmpty {
            let randomIndex: [String].Index = .random(in: 0..<self.emojiChoices.count)
            self.emoji[card.id] = self.emojiChoices.remove(at: randomIndex)
        }

        return self.emoji[card.id] ?? "?"
    }

    // MARK: - Private API -

    private func isMatching(at indices: [CardIndex]) -> Bool {
        let cards = indices.map { self.cards[$0] }
        guard let first = cards.first else {
            return false
        }

        return cards.allSatisfy { $0.id == first.id }
    }

    private func markAsMatched(at indices: [CardIndex]) {
        indices.forEach { self.cards[$0].isMatched = true }
    }

    private func turnFaceUp(at index: CardIndex) {
        self.cards[index].isFaceUp = true

        if self.indexOfOneAndOnlyFaceUpCard != nil {
            self.indexOfOneAndOnlyFaceUpCard = nil
        }
        else {
            self.indexOfOneAndOnlyFaceUpCard = index
        }
    }

    private func turnFaceDownAll() {
        self.cards.indices.forEach { self.cards[$0].isFaceUp = false }
    }

}
