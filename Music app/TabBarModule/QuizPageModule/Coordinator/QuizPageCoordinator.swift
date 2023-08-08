import UIKit
final class QuizPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = QuizPageViewModel()
        let quizPageViewController = QuizPageViewController.instantiate()
        quizPageViewController.viewModel = viewModel
        navigationController.pushViewController(quizPageViewController, animated: true)
    }
}
