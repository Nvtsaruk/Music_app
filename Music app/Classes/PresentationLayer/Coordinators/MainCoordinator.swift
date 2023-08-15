import UIKit

final class MainCoordinator: Coordinator {
    
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
