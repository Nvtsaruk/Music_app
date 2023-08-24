import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showLogin()
}

final class MainCoordinator: Coordinator, MainCoordinatorDelegate {
    
    let navigationController = UINavigationController()
    
    func start() {
        if isUserLoggedIn() {
            startTabBar()
        } else {
            startLogin()
        }
    }
    private func isUserLoggedIn() -> Bool {
        do {
            _ = try KeychainManager.getPassword(for: "access_token")
            return true
        } catch {
            print(error)
            return false
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
