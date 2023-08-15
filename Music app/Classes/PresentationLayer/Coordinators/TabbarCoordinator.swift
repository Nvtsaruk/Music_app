import UIKit

class TabBarCoordinator: Coordinator {
    var coordinator: MainCoordinator?
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let tabBarController = TabBarController()
    
    func start() {
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
