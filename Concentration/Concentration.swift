//
//  Concentration.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 28.05.2024.
//

import Foundation
import UIKit

final class Concentration {

    typealias CardIndex = Array<Card>.Index

    // MARK: - Properties -

    private (set) var cards: [Card] = []
    private (set) var flipCount: Int = 0
    private (set) var score: Int = 0

    let cardBackgroundColor: UIColor

    private var emojiChoices: [String]
    private var emoji = [Int: String]()
    private var indicesOfSeenCards: Set<CardIndex> = []

    private var indexOfOneAndOnlyFaceUpCard: CardIndex?

    // MARK: - Init -

    init(numberOfCards: Int, theme: ConcentrationTheme) {
        self.emojiChoices = theme.getEmojis()
        self.cardBackgroundColor = theme.getThemeCardBackgroundColor()
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
                self.score += 2
            }
            else {
                penalize(at: [chosenIndex, matchIndex])
            }
        }
        else {
            turnFaceDownAll()
        }

        turnFaceUp(at: chosenIndex)
        self.flipCount += 1
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

    private func penalize(at indices: [CardIndex]) {
        indices.forEach {
            if self.indicesOfSeenCards.contains($0) {
                self.score -= 1
            }
            else {
                self.indicesOfSeenCards.insert($0)
            }
        }
    }

}
