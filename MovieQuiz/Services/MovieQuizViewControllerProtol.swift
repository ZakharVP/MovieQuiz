//
//  MovieQuizViewControllerProtol.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 24.07.2024.
//

import Foundation

protocol MovieQuizViewControllerProtol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highLightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
