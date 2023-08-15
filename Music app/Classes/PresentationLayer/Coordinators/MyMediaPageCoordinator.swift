import UIKit
final class MyMediaPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MyMediaPageViewModel()
        let myMediaPageViewController = MyMediaPageViewController.instantiate()
        myMediaPageViewController.viewModel = viewModel
        navigationController.pushViewController(myMediaPageViewController, animated: true)
    }
}
