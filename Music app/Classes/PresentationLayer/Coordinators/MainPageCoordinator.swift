import UIKit

//protocol MainPage: Coordinator {
//    func goToUserProfile()
//}

class MainPageCoordinator: Coordinator {
    
    weak var delegate: MainCoordinatorDelegate?
    
    let navigationController: UINavigationController
    let playerViewModel: PlayerViewModel
    
    init(navigationController: UINavigationController, playerViewModel: PlayerViewModel) {
        self.navigationController = navigationController
        self.playerViewModel = playerViewModel
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
    
    func showUserDetails(currentUser: UserProfile) {
        let viewModel = UserDetailsViewModel()
        viewModel.coordinator = self
        viewModel.currentUser = currentUser
        // TODO: - delegate
        let userDetailsViewController = UserDetailsViewController.instantiate()
        userDetailsViewController.viewModel = viewModel
        navigationController.pushViewController(userDetailsViewController, animated: true)
    }
    
    func showItemDetail(id: String) {
        let viewModel = ItemDetailViewModel()
        viewModel.coordinator = self
        viewModel.id = id
        let itemDetailViewController = ItemDetailViewController.instantiate()
        itemDetailViewController.viewModel = viewModel
        navigationController.pushViewController(itemDetailViewController, animated: true)
    }
    
    func showLogin() {
        delegate?.showLogin()
    }
}



