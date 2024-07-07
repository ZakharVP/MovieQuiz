//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 07.07.2024.
//

import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion() -> QuizQuestion?
}
