import UIKit
class LoginCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        let model = LoginViewModel()
        model.coordinator = self
        loginViewController.viewModel = model
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
