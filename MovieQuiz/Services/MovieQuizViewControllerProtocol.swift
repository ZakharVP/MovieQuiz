//
//  MovieQuizViewControllerProtol.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 24.07.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    func highLightImageBorder(isCorrectAnswer: Bool)
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)

}
