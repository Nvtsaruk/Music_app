import UIKit

final class TabBarController: UITabBarController, MainCoordinatorDelegate, AudioPlayerShowHideDelegate {
    //MARK: - Variables
    var playerInited: Bool = false
    var timer = Timer()
    var coordinator: MainCoordinatorDelegate?
    var player: PlayerView = PlayerView()
    var playerViewModel: PlayerViewModelProtocol?
    
    private enum TabBarItems {
        case mainPage
        case searchPage
        case myMedia
        
        var title: String {
            switch self {
                case .mainPage:
                    return MainScreenLocalization.main.string
                case .searchPage:
                    return MainScreenLocalization.search.string
                case .myMedia:
                    return MainScreenLocalization.media.string
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
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    func showLogin() {
        coordinator?.showLogin()
    }
    
    private func setupTabBar() {
        AudioPlayerService.shared.showHideDelegate = self
        
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
        
        viewControllers = [mainPageViewController.navigationController,
                           searchPageViewController.navigationController,
                           mediaPageViewController.navigationController
        ]
        
        viewControllers?[0].tabBarItem.title = TabBarItems.mainPage.title
        viewControllers?[0].tabBarItem.image = UIImage(systemName: TabBarItems.mainPage.iconName)
        viewControllers?[1].tabBarItem.title = TabBarItems.searchPage.title
        viewControllers?[1].tabBarItem.image = UIImage(systemName: TabBarItems.searchPage.iconName)
        viewControllers?[2].tabBarItem.title = TabBarItems.myMedia.title
        viewControllers?[2].tabBarItem.image = UIImage(systemName: TabBarItems.myMedia.iconName)
    }
    
    func showCompactPlayer() {
        if playerInited == false {
            showPlayerView()
            playerInited = true
        }
    }
    
    func showFullPlayer() {
        removeView()
        showFullPlayerView()
    }
    
    private func removeView() {
        hideView()
        player.removeFromSuperview()
        self.playerInited = false
    }
    private func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.player.alpha = 0
        })
    }
    
    private func showPlayerView() {
        player.frame = CGRect(x: 0, y: view.frame.height - 145, width: view.frame.width, height: 60)
        let playerViewModel = PlayerViewModel()
        player.viewModel = playerViewModel
        view.addSubview(player)
        UIView.animate(withDuration: 0.3, animations: {
            self.player.alpha = 1
        })
    }
    
    private func showFullPlayerView() {
        removeView()
        let fullPlayer = FullPlayerViewController.instantiate()
        let viewModel = FullPlayerModel()
        fullPlayer.viewModel = viewModel
        fullPlayer.modalPresentationStyle = .fullScreen
        present(fullPlayer, animated: true)
    }
}

extension TabBarController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .TabBarController
    }
}


