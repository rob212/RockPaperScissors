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
    
    func buttonPressed(withIndex selection: Int) {
        print("\(selection) button was tapped, and the current move is index id: \(currentMove)")
        turnCounter += 1
        
        if selection == currentMove {
            score += 1
        } else {
            score -= 1
        }
        
        if turnCounter >= 10 {
            endGame()
        } else {
            nextRound()
        }
    }
    
    func nextRound() {
        print("Next Round")
    }
    
    func endGame() {
        print("EndGame called")
        score = 0
        turnCounter = 0
        nextRound()
    }
    
    var body: some View {
        
        
        VStack {
            Text("Score: \(score)")
            Text("Move: \(moves[currentMove])")
                .font(.largeTitle)
            Text("Try and \(shouldWin ? "WIN" : "LOSE")!")
            
            Spacer()
            
            ForEach(Array(moves.enumerated()), id: \.element) { index, move in
                Button(action: {
                    buttonPressed(withIndex: index)
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
    }
}

#Preview {
    ContentView()
}
