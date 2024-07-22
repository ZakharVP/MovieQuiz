//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Захар Панченко on 14.07.2024.
//

import UIKit

protocol AlertPresenterProtocol {
    func show(alertModel: AlertModel)
}

final class AlertPresenter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
}

extension AlertPresenter: AlertPresenterProtocol{
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
           alertModel.buttonAction()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
        
    }
    
}
