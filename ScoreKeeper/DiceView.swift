//
//  DiceView.swift
//  ScoreKeeper
//
//  Created by Dhruv Naik on 31/01/25.
//

import SwiftUI

struct DiceView: View {
    
    @State private var numberOfPips: Int = 6;
    @Binding var currentPlayerIndex: Int;
    @Binding var iterationCount: Int;
    @Binding var players: [Player];
    @Binding var winner: String;
    @Binding var gameOver: Bool;
    @Binding var startGame: Bool;
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(numberOfPips)")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top)
           
            Button("Start Game"){
                startGame = true;
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .padding(.top)
            
            Button("Roll"){
                withAnimation{
                    numberOfPips = Int.random(in: 1...6)
                    
                    players[currentPlayerIndex].score += numberOfPips
                    
                    iterationCount += 1;
                    
                    if iterationCount == 3 {
                        if currentPlayerIndex == players.count - 1 {
                            findMaxScore()
                            gameOver = true
                            startGame = false
                        }
                        else{
                            iterationCount = 0
                            currentPlayerIndex = (currentPlayerIndex + 1) % players.count;
                        }
                    }
                }
            }.disabled(startGame == false)
            
            
            .buttonStyle(.bordered)
        }
    }
    
    func findMaxScore() {
        var maxScore = players[0].score;
        var winningPlayer = players[0].name;
        
        for i in players{
            if(i.score > maxScore){
                maxScore = i.score;
                winningPlayer = i.name;
            }
        }
        
        winner = winningPlayer
        
    }
}

#Preview {
    DiceView(currentPlayerIndex: .constant(0)  , iterationCount: .constant(0) , players: .constant([Player(name: "Dhruv", score: 0),
                            Player(name: "Omkar", score: 0),
                            Player(name: "Shivam", score: 0)]),
                            winner: .constant(""),
                            gameOver: .constant(false),
                            startGame: .constant(false)
    )
}
