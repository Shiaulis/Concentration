//
//  ViewController.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 28.05.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties -

    private lazy var game = Concentration(numberOfCards: self.cardButtons.count, theme: .allCases.randomElement() ?? .animals)

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    // MARK: - Actions -

    @IBAction private func newGameTapped(_ sender: UIButton) {
        self.game = Concentration(numberOfCards: self.cardButtons.count, theme: .getRandomTheme())
        updateViewFromModel()
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            assertionFailure("chosen card was not in cardButtons")
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : self.game.cardBackgroundColor
            }
        }

        self.flipCountLabel.text = "Flips: \(self.game.flipCount)"
        self.scoreLabel.text = "Score: \(self.game.score)"
    }

}

