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
final class TabBarController: UITabBarController, MainCoordinatorDelegate, AudioPlayerShowHideDelegate {
    func showPlayer() {
        showView()
    }
    
    func hidePlayer() {
        
    }
    
    
    
    //final class TabBarController: GradientTabBarController, MainCoordinatorDelegate {
    var timer = Timer()
    var coordinator: MainCoordinatorDelegate?
    var playerViewController: CollapsedPlayerViewController = CollapsedPlayerViewController()
    var player: PlayerView = PlayerView()
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
        AudioPlayerService.shared.showHideDelegate = self
    }
    func showLogin() {
        coordinator?.showLogin()
    }
    
    private func setupTabBar() {
        let playerViewModel = PlayerViewModel()
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .black
        
        let mainPageViewController = MainPageCoordinator(navigationController: UINavigationController(), playerViewModel: playerViewModel)
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
        
        player.frame = CGRect(x: 0, y: view.frame.height - 145, width: view.frame.width, height: 60)
        
//        print("Player in tabbar", player)
        player.viewModel = playerViewModel
//        print("In tab bar ", player?.viewModel)
        print("Player in tabbar", player)
        self.view.addSubview(player)
//        showView()
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(removeView), userInfo: nil, repeats: true)
    }
    
    @objc func removeView() {
        hideView()
//        player.removeFromSuperview()
    }
    private func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.player.alpha = 0
            })
    }
    
    private func showView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.player.alpha = 1
            })
    }
    
    
}
extension TabBarController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .TabBarController
    }
}


