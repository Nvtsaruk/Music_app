import UIKit

class TabBarCoordinator: Coordinator, MainCoordinatorDelegate {
    
    var coordinator: MainCoordinatorDelegate?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
//    userDetailsViewController.viewModel = viewModel
    let tabBarController = TabBarController()
    
    func start() {
//        let tabBarController = TabBarController.instantiate()
        tabBarController.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func showLogin() {
        coordinator?.showLogin()
    }
}

