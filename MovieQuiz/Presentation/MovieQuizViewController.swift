import UIKit

final class MovieQuizViewController: UIViewController{
                
    // MARK: - IB Outlets
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var questionTitleLabel: UILabel!
    
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private var alertPresenter: AlertPresenter?
    private var statisticService: StatisticService?
    private var presenter: MovieQuizPresenter!
            
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
                              
        super.viewDidLoad()
                
        questionTitleLabel.font = UIFont(name: "YSDisplay-Bold", size: 23.0)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        imageView.layer.cornerRadius = 20
        
        presenter = MovieQuizPresenter(viewController: self)
        
        alertPresenter = AlertPresenter(viewController: self)
        statisticService = StatisticService()
        
        showLoadingIndicator()
    }
    
       
    // MARK: - IB Actions
    @IBAction private func yesButtonCliked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    @IBAction private func noButtonCliked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    // MARK: - Private Methods
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator(){
        activityIndicator.isHidden = true
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробывать еще раз",
            buttonAction: { [weak self] in
                self?.presenter.restartGame()
        })
        alertPresenter?.show(alertModel: alertModel)       
    }
    
    func show(quiz step: QuizStepViewModel){
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    func show(quiz result: QuizResultsViewModel){
        
        statisticService?.store(correct: presenter.correctAnswers, total: presenter.questionsAmount)
        
        let alertModel = AlertModel(
            title: "Игра окончена!",
            message: makeResultMessage(),
            buttonText: "Ок",
            buttonAction: { [weak self] in
                self?.presenter.restartGame()
                
            }
        )
        alertPresenter?.show(alertModel: alertModel)
       
    }
    private func makeResultMessage() -> String{
        guard let statisticService = statisticService, let bestGame = statisticService.bestGame else {
            assertionFailure("error message")
            return ""
        }
        
        let accuracy = String(format:"%.2f", statisticService.totalAccuracy)
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(presenter.correctAnswers)\\\(presenter.questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)\\\(bestGame.total)" + " " + " \(bestGame.date.dateTimeString)"
        let averageAccuracyLine = "Средняя точность: \(accuracy)%"
        
        let resultMessage = [
        currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine
        ].joined(separator: "\n")
        
        return resultMessage
    }
    func showAnswerResult(isCorrect: Bool) {
        presenter.didAnswer(isYes: isCorrect)
        if isCorrect {
            presenter.correctAnswers += 1
        }
                
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
              
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return}
            self.presenter.showNextQuestionOrResults()
        }
        
    }
    
}


/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
