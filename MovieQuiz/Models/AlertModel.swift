//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 14.07.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let buttonAction: () -> Void
}

