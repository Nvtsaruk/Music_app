import UIKit

//protocol MainPage: Coordinator {
//    func goToUserProfile()
//}

class MainPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print(self)
        let viewModel = MainPageViewModel()
        viewModel.coordinator = self
        let mainPageViewController = MainPageViewController.instantiate()
        mainPageViewController.viewModel = viewModel
        print(mainPageViewController)
        navigationController.pushViewController(mainPageViewController, animated: true)
    }
    
    func goToUserProfile() {
        print("Button")
        let viewModel = UserProfileViewModel()
        let userProfileViewController = UserProfileViewController.instantiate()
        userProfileViewController.viewModel = viewModel
        navigationController.pushViewController(userProfileViewController, animated: true)
    }

    
}



