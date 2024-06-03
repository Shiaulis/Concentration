//
//  ConcentrationTheme.swift
//  Concentration
//
//  Created by Andrius Shiaulis on 03.06.2024.
//

import Foundation



enum ConcentrationTheme: String, CaseIterable {

    // MARK: - Properties -

    // MARK: - Cases -

    case animals = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯"
    case sports = "🏀🏈⚽️⚾️🎾🏐🏉🎱🏓🏸"
    case faces = "😀😃😄😁😆😅😂🤣😊😇"
    case buildings = "🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪"
    case fruits = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈"
    case vehicles = "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐"

    func getEmojis() -> [String] {
        self.rawValue.map { String($0) }
    }

}
