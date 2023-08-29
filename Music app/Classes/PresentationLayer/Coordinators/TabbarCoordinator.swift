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
//        let player = PlayerView()
//        tabBarController.player = player
        tabBarController.coordinator = self
//        print(tabBarController.player)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func showLogin() {
        coordinator?.showLogin()
    }
}

