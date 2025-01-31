//
//  Player.swift
//  ScoreKeeper
//
//  Created by Dhruv Naik on 31/01/25.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}


