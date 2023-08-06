import UIKit

class TabBarCoordinator: Coordinator {
    
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
