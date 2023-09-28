import Foundation

protocol MainPageViewModelProtocol {
    func logout()
    func getPlaylists()
    func start()
    func showItemDetail(id: String)
    var mainPageData: MainPageData { get }
    var updateClosure:( ()->Void )? { get set }
    var isLoading: Bool { get }
}
enum CellType {
    case header
    case topPlaylists
    case playlists
}

struct MainPageData {
    var playlistNames: [String]
    var playlists: [Toplist]
    var numRows: [Int]
    init(playlistNames: [String] = [], playlists: [Toplist] = [], numRows: [Int] = []) {
        self.playlistNames = playlistNames
        self.playlists = []
        self.numRows = numRows
    }
}


final class MainPageViewModel: MainPageViewModelProtocol {
    
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    var mainPageData: MainPageData = MainPageData() {
        didSet {
            updateClosure?()
        }
    }

    func getPlaylists() {
        isLoading = true
        for cases in APIUrls.allCases {
            APIService.getData(Toplist.self, url: cases.url) { result in
                switch result {
                    case .success(let data):
                        self.mainPageData.playlistNames.append(cases.name)
                        self.mainPageData.playlists.append(data)
                        self.mainPageData.numRows.append(data.playlists.items.count)
                    case .failure(let error):
                        print("Custom Error -> \(error)")
                }
            }
        }
        isLoading = false
    }

    
    func start() {
        let headerCell = HeaderTableViewCell()
        headerCell.delegate = self
        getPlaylists()
    }
    
    func showItemDetail(id: String) {
        coordinator?.showItemDetail(id: id)
    }
    
    func logout() {
        LoginManager.shared.deleteAll()
    }
    
}


extension MainPageViewModel: HeaderTableViewCellDelegate {
    func goToUserProfile() {
        coordinator?.goToUserProfile()
    }
}

