import UIKit
final class MyMediaPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MyMediaPageViewModel()
        viewModel.coordinator = self
        let myMediaPageViewController = MyMediaPageViewController.instantiate()
        myMediaPageViewController.viewModel = viewModel
        navigationController.pushViewController(myMediaPageViewController, animated: true)
    }
    func showItemDetail(id: String, playlist: PlaylistModel) {
        let viewModel = PlaylistItemDetailViewModel()
        viewModel.playlist = playlist
        viewModel.details = playlist.name
        let itemDetailViewController = PlaylistItemDetailViewController.instantiate()
        itemDetailViewController.viewModel = viewModel
        navigationController.pushViewController(itemDetailViewController, animated: true)
    }
}
