//
//  ViewController.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 28.05.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties -

    private static var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "👹"]

    private var emoji: Dictionary<Int, String> = [:]
    private lazy var game = Concentration(numberOfCards: self.cardButtons.count, theme: .allCases.randomElement() ?? .animals)

    private var flipCount = 0 {
        didSet {
            self.flipCountLabel.text = "Flips: \(self.flipCount)"
        }
    }

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!

    // MARK: - Actions -

    @IBAction func newGameTapped(_ sender: UIButton) {
        Self.emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "👹"]
        self.game = Concentration(numberOfCards: self.cardButtons.count, theme: .allCases.randomElement() ?? .animals)
        self.flipCount = 0
        updateViewFromModel()
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        self.flipCount += 1

        if let cardNumber = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }

    // MARK: - Private API -

    private func updateViewFromModel() {
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            let card = self.game.cards[index]
            if card.isFaceUp {
                button.setTitle(self.game.generateEmoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

}

