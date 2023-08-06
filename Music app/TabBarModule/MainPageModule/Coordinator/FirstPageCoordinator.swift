import UIKit
final class MainPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
        guard let mainPageViewController = storyboard.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
        navigationController.pushViewController(mainPageViewController, animated: true)
    }
    
    @objc private func backButtonTapped() {
        navigationController.popViewController(animated: true)
    }
    
    func getViewController<T>(_ type: T.Type,
                              _ identifier: String) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: String(describing: identifier), bundle: nil)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("ViewController is not type of \(String(describing: self))")
        }
        return controller
    }
    
}

