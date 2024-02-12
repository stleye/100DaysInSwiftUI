//
//  RockPaperScissorsApp.swift
//  RockPaperScissors
//
//  Created by Sebastian Tleye on 12/02/2024.
//

import SwiftUI

@main
struct RockPaperScissorsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
