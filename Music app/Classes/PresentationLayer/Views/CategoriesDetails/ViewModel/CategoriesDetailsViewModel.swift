protocol CategoriesDetailsViewModelProtocol {
    var updateClosure:( ()->Void )? { get set }
    var name: String { get set }
    var playlists: Toplist? { get }
    var isLoading: Bool { get }
    func showItemDetail(id: String)
}
final class CategoriesDetailsViewModel: CategoriesDetailsViewModelProtocol {
    
    var coordinator: SearchPageCoordinator?
    
    var playlists: Toplist? {
        didSet {
            updateClosure?()
        }
    }
    var updateClosure: (() -> Void)?
    var id: String = ""{
        didSet {
            getPlaylist()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    var name: String = ""
    
    func getPlaylist() {
        isLoading = true
        APIService.getData(Toplist.self, url: NetworkConstants.baseUrl + NetworkConstants.categories + id + "/playlists") { result in
            switch result {
                case .success(let data):
                    self.playlists = data
                case .failure(let error):
                    ErrorHandler.shared.handleError(error: error)
            }
        }
    }
    func showItemDetail(id: String) {
        coordinator?.showPlaylistDetail(id: id)
    }
    
}
