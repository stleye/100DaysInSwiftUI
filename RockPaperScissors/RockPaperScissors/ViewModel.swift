//
//  ViewModel.swift
//  RockPaperScissors
//
//  Created by Sebastian Tleye on 12/02/2024.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var game = Game(score: 0)

    var score: Int {
        game.score
    }
    
    var gameResult: Game.Outcome? {
        game.result
    }

    func play(_ choice: Game.PlayerChoice) {
        game.play(choice)
    }

}

extension Game.PlayerChoice {
    
    func emoji() -> String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📄"
        case .scissors:
            return "✂️"
        }
    }
    
}

extension Game.Outcome {
    
    func title() -> String {
        switch self {
        case .win:
            return "You Won!"
        case .lose:
            return "You Lose!"
        case .tie:
            return "It's a tie!"
        }
    }
    
}
