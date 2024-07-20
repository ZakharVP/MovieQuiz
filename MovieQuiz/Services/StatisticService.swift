//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 14.07.2024.
//

import Foundation

final class StatisticService {
    
    private enum Keys: String {
        case correct
        case total
        case bestGame
        case gamesCount
    }
    
    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let dateProvider: () -> Date
    
    init (
        userDefaults: UserDefaults = .standard,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder(),
        dateProvider: @escaping () -> Date = { Date() }
    ) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
        self.dateProvider = dateProvider
    }
}

extension StatisticService: StatisticServiceProtocol {
     
    var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
   
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: BestGame? {
        get {
            guard
                let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let bestGame = try? decoder.decode(BestGame.self, from: data) else {
                return nil
                
            }
            return bestGame
        }
        set {
            let data = try? encoder.encode(newValue)
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
            
        }
    }
    
    var totalAccuracy: Double {
        Double (correct) / Double(total) * 100
    }
    
    func store(correct: Int, total: Int) {
        self.correct += correct
        self.total += total
        self.gamesCount += 1
        
        let date = dateProvider()
        let currentBestGame = BestGame(correct: correct, total: total, date: date)
        
        if let previousBestGame = bestGame {
            if currentBestGame > previousBestGame {
                bestGame = currentBestGame
            }
        } else {
            bestGame = currentBestGame
        }
    }
    
}
