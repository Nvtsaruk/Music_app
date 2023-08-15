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
        let viewModel = MainPageViewModel()
        viewModel.coordinator = self
        let mainPageViewController = MainPageViewController.instantiate()
        mainPageViewController.viewModel = viewModel
        navigationController.pushViewController(mainPageViewController, animated: true)
    }
    
    func goToUserProfile() {
        let viewModel = UserProfileViewModel()
        viewModel.coordinator = self
        let userProfileViewController = UserProfileViewController.instantiate()
        userProfileViewController.viewModel = viewModel
        navigationController.pushViewController(userProfileViewController, animated: true)
    }
    
    func showUserDetails() {
        let viewModel = UserDetailsViewModel()
        viewModel.coordinator = self
        let userDetailsViewController = UserDetailsViewController.instantiate()
        userDetailsViewController.viewModel = viewModel
        navigationController.pushViewController(userDetailsViewController, animated: true)
    }
    
    func showLogin() {
        
    }

    
}



