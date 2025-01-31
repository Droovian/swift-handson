//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Dhruv Naik on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var players: [Player] = []
    
    @State private var rounds: Int = 0
    @State private var currentPlayerIndex: Int = 0
    @State private var iterationCount: Int = 0
    @State private var winner: String = ""
    @State private var gameOver: Bool = false;
    @State private var newPlayerName: String = ""
    @State private var startGame: Bool = false;
    
    var body: some View {
        VStack {
            
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .resizable()
                    .frame(width: 60, height: 30)
                
                Text("The Dice Game")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
            }
            
            
            Grid{
                GridRow{
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                }
                .font(.headline)
                ForEach($players){ $player in
                    GridRow{
                        TextField("Name", text: $player.name)
                        Text("\(player.score)")
                    }
                }
                HStack {
                        TextField("Enter new player's name", text: $newPlayerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing)
                            .disabled(startGame == true)
                                    
                        Button("Add Player") {
                            let newPlayer = Player(name: newPlayerName, score: 0)
                            players.append(newPlayer)
                            newPlayerName = ""
                        }
                        .disabled(startGame == true)
                        
                       
                }
                .padding(.top)
                
                if(!players.isEmpty){
                    Text("\(players[currentPlayerIndex].name)! its your chance")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                }
            
                if(!gameOver){
                    DiceView(
                        currentPlayerIndex: $currentPlayerIndex,
                        iterationCount: $iterationCount,
                        players: $players,
                        winner: $winner,
                        gameOver: $gameOver,
                        startGame: $startGame
                    )
                }
                
                if gameOver {
                    VStack{
                        Text("Congrats on the win \(winner)")
                            .font(.headline)
                            .padding(.top)
                        
                        Button("Restart game"){
                            currentPlayerIndex = 0
                            iterationCount = 0
                            winner = ""
                            gameOver = false
                            players = players.map { player in
                                Player(name: player.name, score: 0)
                            }
                        }
                    }
                    
                    
                    
                }
    
            }
            .padding(.vertical)
        
            Spacer()
            
            Button("Reset Players"){
                players = []
            }.disabled(startGame == true)
            
        }
       
        .padding()
    }
        
    
}

#Preview {
    ContentView()
}
