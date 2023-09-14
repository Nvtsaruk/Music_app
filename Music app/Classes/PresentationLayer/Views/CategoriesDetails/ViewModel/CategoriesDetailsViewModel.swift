protocol CategoriesDetailsViewModelProtocol {
    var updateClosure:( ()->Void )? { get set }
    var name: String { get set }
    var playlists: Toplist? { get }
    func showItemDetail(id: String)
}
final class CategoriesDetailsViewModel: CategoriesDetailsViewModelProtocol {
    
    var coordinator: SearchPageCoordinator?
    
    var playlists: Toplist? = Toplist() {
        didSet {
            print(playlists?.playlists?.items?.count)
            updateClosure?()
        }
    }
    var updateClosure: (() -> Void)?
    var id: String = ""{
        didSet {
            print("ID:",id)
            getPlaylist()
        }
    }
    var name: String = ""{
        didSet {
            print(name)
            
        }
    }
    
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
        coordinator?.showItemDetail(id: id)
    }
    
}
