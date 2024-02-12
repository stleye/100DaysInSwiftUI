//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sebastian Tleye on 12/02/2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ViewModel
    @State var shouldPresentAlert = false

    var body: some View {
        VStack {
            Text("Player's score: \(viewModel.score)")
                .padding(.bottom)
            ForEach(Game.PlayerChoice.allCases) { choice in
                choiceButton(choice)
            }
        }
        .alert("", isPresented: $shouldPresentAlert) {
            Button("Continue") { }
        } message: {
            Text(viewModel.gameResult?.title() ?? "")
        }
    }

    func choiceButton(_ choice: Game.PlayerChoice) -> some View {
        Button(choice.emoji()) {
            viewModel.play(choice)
            shouldPresentAlert = true
        }.font(.system(size: 100))
    }

}

#Preview {
    ContentView(viewModel: ViewModel())
}
