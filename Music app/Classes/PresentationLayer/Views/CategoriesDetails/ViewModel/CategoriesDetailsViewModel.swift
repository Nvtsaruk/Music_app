protocol CategoriesDetailsViewModelProtocol {
    var updateClosure:( ()->Void )? { get set }
    var name: String { get set }
    var playlists: Toplist? { get }
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
    
    var name: String = ""
    
    func getPlaylist() {
        APIService.getData(Toplist.self, url: NetworkConstants.baseUrl + NetworkConstants.categories + id + "/playlists") { result in
            switch result {
                case .success(let data):
                    self.playlists = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    func showItemDetail(id: String) {
        coordinator?.showPlaylistDetail(id: id)
    }
    
}
