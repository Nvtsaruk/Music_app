import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showLogin()
}

final class MainCoordinator: Coordinator, MainCoordinatorDelegate {
    
    let navigationController = UINavigationController()
    
    func start() {
        if CredentialStorageService().isUserLoggedIn() {
            startTabBar()
        } else {
            startLogin()
        }
    }
    
    func showLogin() {
        start()
    }
    
    private func startLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    private func startTabBar() {
        let tabbarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabbarCoordinator.coordinator = self
        tabbarCoordinator.start()
    }
}
