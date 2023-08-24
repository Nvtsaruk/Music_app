import UIKit

class GradientTabBarController: UITabBarController {

        let gradientlayer = CAGradientLayer()

        override func viewDidLoad() {
            super.viewDidLoad()
            setGradientBackground(colorOne: .black, colorTwo: UIColor(white: 1, alpha: 0))
        }

        func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
            gradientlayer.frame = tabBar.bounds
            gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
            gradientlayer.locations = [0, 1]
            gradientlayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        }
}
final class TabBarController: UITabBarController, MainCoordinatorDelegate {
//final class TabBarController: GradientTabBarController, MainCoordinatorDelegate {
    
    var coordinator: MainCoordinatorDelegate?
    
    private enum TabBarItems {
        case mainPage
        case searchPage
        case myMedia
        case quiz
        
        var title: String {
            switch self {
                case .mainPage:
                    return "Main"
                case .searchPage:
                    return "Search"
                case .myMedia:
                    return "My music"
                case .quiz:
                    return "Quiz"
            }
        }
        var iconName: String {
            switch self {
                case .mainPage:
                    return "house.fill"
                case .searchPage:
                    return "magnifyingglass"
                case .myMedia:
                    return "tray.full.fill"
                case .quiz:
                    return "gamecontroller.fill"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
//        loadTabbarFromXib()
    }
    func showLogin() {
        coordinator?.showLogin()
    }
    
    private func loadTabbarFromXib() -> UITabBarController {
        guard let view = Bundle.main.loadNibNamed("TabBarController", owner: self)?.first as? TabBarController else { return UITabBarController() }
        return view
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .black
        
        let mainPageViewController = MainPageCoordinator(navigationController: UINavigationController())
        mainPageViewController.delegate = self
        mainPageViewController.start()
        let searchPageViewController = SearchPageCoordinator(navigationController: UINavigationController())
        searchPageViewController.start()
        let mediaPageViewController = MyMediaPageCoordinator(navigationController: UINavigationController())
        mediaPageViewController.start()
        let quizPageViewController = QuizPageCoordinator(navigationController: UINavigationController())
        quizPageViewController.start()
        
        viewControllers = [mainPageViewController.navigationController,
                           searchPageViewController.navigationController,
                           mediaPageViewController.navigationController,
                           quizPageViewController.navigationController
        ]
        
        viewControllers?[0].tabBarItem.title = TabBarItems.mainPage.title
        viewControllers?[0].tabBarItem.image = UIImage(systemName: TabBarItems.mainPage.iconName)
        viewControllers?[1].tabBarItem.title = TabBarItems.searchPage.title
        viewControllers?[1].tabBarItem.image = UIImage(systemName: TabBarItems.searchPage.iconName)
        viewControllers?[2].tabBarItem.title = TabBarItems.myMedia.title
        viewControllers?[2].tabBarItem.image = UIImage(systemName: TabBarItems.myMedia.iconName)
        viewControllers?[3].tabBarItem.title = TabBarItems.quiz.title
        viewControllers?[3].tabBarItem.image = UIImage(systemName: TabBarItems.quiz.iconName)
        
        let playerView = PlayerView()
//        guard let playerView = Bundle.main.loadNibNamed("PlayerView", owner: self)?.first as? PlayerView else { return }
        playerView.artistNameLabel.text = "qew"
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        view.bringSubviewToFront(playerView)
        
        NSLayoutConstraint.activate([
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
//        let testImage = UIImageView(image: UIImage(named: "tempImage"))
//        testImage.frame = CGRect(x: 100, y: 100, width: 100, height: 200)
//        view.addSubview(testImage)
    }
    
}
extension TabBarController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .TabBarController
    }
}
