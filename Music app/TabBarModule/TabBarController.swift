import UIKit

final class TabBarController: UITabBarController {
    
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
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .black
        
        let mainPageViewController = MainPageCoordinator(navigationController: UINavigationController())
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
    
    }
    
}





//class TabBarController: UITabBarController {
//
//
//
//    private enum TabBarItem: Int {
//
//
//        case mainPage
//        case searchPage
//        case myMedia
//        case quizz
//
//        var title: String {
//            switch self {
//                case .mainPage:
//                    return "Main"
//                case .searchPage:
//                    return "Search"
//                case .myMedia:
//                    return "My music"
//                case .quizz:
//                    return "Quizz"
//            }
//        }
//        var iconName: String {
//            switch self {
//                case .mainPage:
//                    return "house.fill"
//                case .searchPage:
//                    return "person.crop.circle"
//                case .myMedia:
//                    return "person.crop.circle"
//                case .quizz:
//                    return "person.crop.circle"
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupTabBar()
//
//    }
//    private func setupTabBar() {
//
//        tabBar.barTintColor = UIColor.black
//        tabBar.isTranslucent = false
//        tabBar.tintColor = .white
//        tabBar.unselectedItemTintColor = .lightGray
//        tabBar.backgroundColor = .black
//
//        let storyboard = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
//        guard let mainPageViewController = storyboard.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
//        let mainPageViewModel = MainPageViewModel()
//        mainPageViewController.viewModel = mainPageViewModel
//        let storyboard2 = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
//        guard let secondPageViewController = storyboard2.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
//        let storyboard3 = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
//        guard let thirdPageViewController = storyboard3.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
//        let storyboard4 = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
//        guard let fourthPageViewController = storyboard4.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
//        let dataSource: [TabBarItem] = [.mainPage, .searchPage, .myMedia, .quizz]
//        self.viewControllers = dataSource.map {
//            switch $0 {
//                case .mainPage:
//                    return self.wrappedInNavigationController(with: mainPageViewController, title: $0.title)
//                case .searchPage:
//                    return self.wrappedInNavigationController(with: secondPageViewController, title: $0.title)
//                case .myMedia:
//                    return self.wrappedInNavigationController(with: thirdPageViewController, title: $0.title)
//                case .quizz:
//                    return self.wrappedInNavigationController(with: fourthPageViewController, title: $0.title)
//            }
//        }
//
//        self.viewControllers?.enumerated().forEach {
//            $1.tabBarItem.title = dataSource[$0].title
//            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
//            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
//        }
//    }
//    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
//            return UINavigationController(rootViewController: with)
//        }
//
//}

