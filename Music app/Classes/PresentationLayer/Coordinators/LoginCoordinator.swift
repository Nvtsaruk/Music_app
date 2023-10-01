import UIKit
final class LoginCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController.instantiate()
        let model = LoginViewModel()
        model.coordinator = self
        loginViewController.viewModel = model
        navigationController.pushViewController(loginViewController, animated: true)
    }
    func showTabBar() {
        let tabbarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabbarCoordinator.start()
    }
}
