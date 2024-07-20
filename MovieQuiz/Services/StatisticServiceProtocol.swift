//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 14.07.2024.
//

import Foundation

protocol StatisticServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(correct: Int, total: Int)
}

