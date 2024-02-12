//
//  Move.swift
//  RockPaperScissors
//
//  Created by Sebastian Tleye on 12/02/2024.
//

import Foundation

struct Game {

    var score: Int
    var result: Outcome?

    enum Outcome {
        case win
        case lose
        case tie
    }

    enum PlayerChoice: CaseIterable, Identifiable {
        
        var id: PlayerChoice { return self }
        
        case rock
        case paper
        case scissors
        
        static func random() -> PlayerChoice {
            return Array(PlayerChoice.allCases).randomElement()!
        }
    }

    mutating func play(_ userChoice: PlayerChoice) {
        result = userDidChoose(userChoice)
        switch result {
        case .win:
            score += 10
        case .lose:
            score -= 10
        case .tie:
            break
        case .none:
            break
        }
    }

    private func userDidChoose(_ userChoice: PlayerChoice) -> Outcome {
        let computerChoice = PlayerChoice.random()
        switch userChoice {
        case .rock:
            switch computerChoice {
            case .rock:
                return .tie
            case .paper:
                return .lose
            case .scissors:
                return .win
            }
        case .paper:
            switch computerChoice {
            case .rock:
                return .win
            case .paper:
                return .tie
            case .scissors:
                return .lose
            }
        case .scissors:
            switch computerChoice {
            case .rock:
                return .lose
            case .paper:
                return .win
            case .scissors:
                return .tie
            }
        }
    }
     
}
