import UIKit
class LoginCoordinator: Coordinator {
    func goToUserProfile() {
        
    }
    
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
        print("go to tabbar")
        let tabbarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabbarCoordinator.start()
    }
}
