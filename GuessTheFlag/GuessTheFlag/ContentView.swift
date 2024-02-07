//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Tleye on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var reset = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAsked = 1
    private let numberOfQuestions = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button(action: {
                            flagTapped(number)
                        }, label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Text("Question: \(questionsAsked)/\(numberOfQuestions)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding()
        }
        .alert("Final Score: \(score)", isPresented: $reset) {
            Button("Reset", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            let wrongFlag = countries[number]
            scoreTitle = "Wrong!, That's the flag of \(wrongFlag)"
            score -= 5
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
        if questionsAsked == numberOfQuestions + 1 {
            reset = true
        }
    }
    
    func resetGame() {
        questionsAsked = 1
        reset = true
        score = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
