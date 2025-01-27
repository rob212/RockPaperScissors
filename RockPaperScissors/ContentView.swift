//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Rob McBryde on 27/01/2025.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["👊", "✋", "✌️"]
    @State private var currentMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turnCounter = 0
    @State private var showingScore = false
    
    func buttonPressed(withIndex selection: Int, usersMove: String) {
        turnCounter += 1
        
        if (shouldWin && isUserCorrect(userSelection: usersMove)) || (shouldWin == false && !isUserCorrect(userSelection: usersMove)) {
            score += 1
        } else {
            score -= 1
        }
        
        if turnCounter >= 10 {
            showingScore = true
        } else {
            nextRound()
        }
    }
    
    private func isUserCorrect(userSelection: String) -> Bool {
        switch moves[currentMove] {
        case "👊":
            return userSelection == "✋"
        case "✋":
            return userSelection == "✌️"
        case "✌️":
            return userSelection == "👊"
        default:
            return false
        }
    }
    
    private func nextRound() {
        shouldWin.toggle()
        currentMove = Int.random(in: 0..<moves.count)
    }
    
    private func endGame() {
        score = 0
        turnCounter = 0
        showingScore = false
        nextRound()
    }
    
    var body: some View {
        
        VStack {
            Text("Score: \(score)")
            Text("Move: \(moves[currentMove])")
                .font(.largeTitle)
                .padding()
            Text("Try and \(shouldWin ? "WIN" : "LOSE")!")
            
            Spacer()
            
            ForEach(Array(moves.enumerated()), id: \.element) { index, move in
                Button(action: {
                    buttonPressed(withIndex: index, usersMove: move)
                }) {
                    Text(move)
                        .padding()
                        .background(Color.secondary)
                        .cornerRadius(10)
                        .font(.system(size: 100))
                        
                }
            }
            Spacer()
            Spacer()
        }
        .padding()
        .alert("Game Over", isPresented: $showingScore) {
            Button("New Game?", action: endGame)
        } message: {
            Text("Your final score is \(score)")
        }
        
    }
}

#Preview {
    ContentView()
}
