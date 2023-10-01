import UIKit

final class SearchPageCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SearchCategoriesViewModel()
        viewModel.coordinator = self
        let searchCategoriesViewController = SearchCategoriesPageViewController.instantiate()
        searchCategoriesViewController.viewModel = viewModel
        navigationController.pushViewController(searchCategoriesViewController, animated: false)
    }
    
    func showSearchTabbar() {
        let viewModel = SearchPageViewModel()
        viewModel.coordinator = self
        let searchPageViewController = SearchPageViewController.instantiate()
        searchPageViewController.viewModel = viewModel
        navigationController.pushViewController(searchPageViewController, animated: false)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: false)
    }
    
    func showDetails(id: String, name: String) {
        let viewModel = CategoriesDetailsViewModel()
        viewModel.coordinator = self
        viewModel.id = id
        viewModel.name = name
        let categoriesDetailsViewController = CategoriesDetailsViewController.instantiate()
        categoriesDetailsViewController.viewModel = viewModel
        navigationController.pushViewController(categoriesDetailsViewController, animated: true)
    }
    
    func showPlaylistDetail(id: String) {
        let viewModel = PlaylistItemDetailViewModel()
        viewModel.id = id
        let playlistItemDetailViewController = PlaylistItemDetailViewController.instantiate()
        playlistItemDetailViewController.viewModel = viewModel
        navigationController.pushViewController(playlistItemDetailViewController, animated: true)
    }
    
    func showArtistDetail(id: String) {
        let viewModel = ArtistItemDetailViewModel()
        viewModel.coordinator = self
        viewModel.id = id
        let artistItemDetailVC = ArtistItemDetailViewController.instantiate()
        artistItemDetailVC.viewModel = viewModel
        navigationController.pushViewController(artistItemDetailVC, animated: true)
    }
    
    func showAlbumDetail(id: String) {
        let viewModel = AlbumItemDetailViewModel()
        viewModel.coordinator = self
        viewModel.id = id
        let albumItemDetailVC = AlbumItemDetailViewController.instantiate()
        albumItemDetailVC.viewModel = viewModel
        navigationController.pushViewController(albumItemDetailVC, animated: true)
    }
    
    func showAddToPlaylist(trackItem: UserPlaylistTrack) {
        let viewModel = AddToPlaylistViewModel()
        viewModel.trackItem = trackItem
        let addToPlaylistVC = AddToPlaylistViewController.instantiate()
        addToPlaylistVC.viewModel = viewModel
        navigationController.present(addToPlaylistVC, animated: true)
    }
}
