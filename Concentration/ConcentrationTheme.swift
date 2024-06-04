//
//  ConcentrationTheme.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 03.06.2024.
//

import Foundation
import UIKit

enum ConcentrationTheme: String, CaseIterable {

    // MARK: - Cases -

    case animals = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯"
    case sports = "🏀🏈⚽️⚾️🎾🏐🏉🎱🏓🏸"
    case faces = "😀😃😄😁😆😅😂🤣😊😇"
    case buildings = "🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪"
    case fruits = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈"
    case vehicles = "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐"

    // MARK: - Public API -

    func getEmojis() -> [String] {
        self.rawValue.map { String($0) }
    }

    func getThemeCardBackgroundColor() -> UIColor {
        switch self {
        case .animals:
            return .systemGreen
        case .sports:
            return .systemBlue
        case .faces:
            return .systemYellow
        case .buildings:
            return .systemGray
        case .fruits:
            return .systemOrange
        case .vehicles:
            return .systemRed
        }
    }

    static func getRandomTheme() -> ConcentrationTheme {
        ConcentrationTheme.allCases.randomElement() ?? .animals
    }

}
