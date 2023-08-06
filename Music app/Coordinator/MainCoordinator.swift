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
            let data = try KeychainManager.getPassword(for: "access_token")
            print("Data from keychain", String(decoding: data ?? Data(), as: UTF8.self))
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
//        let tabbarCoordinator = TabBarCoordinator()
//        tabbarCoordinator.start()
//        let temp = MainPageCoordinator(navigationController: navigationController)
//        temp.start()
        let tabbarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabbarCoordinator.start()
        print("Starting tabbar")
    }
}
