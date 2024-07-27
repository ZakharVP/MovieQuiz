//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 14.07.2024.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    func show(alertModel: AlertModel) {
        
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        alert.view.accessibilityIdentifier = "id"
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
           alertModel.buttonAction()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
        
    }
}
