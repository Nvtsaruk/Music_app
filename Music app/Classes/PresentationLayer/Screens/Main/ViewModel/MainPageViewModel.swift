import Foundation

protocol MainPageViewModelProtocol {
    func logout()
    func getPlaylists()
//    func getToplist()
    func start()
    func showItemDetail(id: String)
    var mainPageData: MainPageData { get }
    var updateClosure:( ()->Void )? { get set }
}
enum CellType {
    case header
    case topPlaylists
    case playlists
}

struct MainPageData {
    var topPlaylists: Toplist?
    var playlists: [Toplist]
    var numRows: [Int]
    init(topPlaylists: Toplist? = nil,playlists: [Toplist]? = nil, numRows: [Int] = []) {
        self.topPlaylists = topPlaylists
        self.playlists = playlists ?? []
        self.numRows = numRows
    }
}


final class MainPageViewModel: MainPageViewModelProtocol {
    
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    
    var mainPageData: MainPageData = MainPageData() {
        didSet {
            updateClosure?()
            print(mainPageData.playlists.count)
            
        }
    }
    
//    func getToplist() {
//        let url = APIUrls.topPlaylists.url
//        APIService.getData(Toplist.self, url: url) { result in
//            switch result {
//                case .success(let data):
//                    self.mainPageData.topPlaylists = data
//                    self.mainPageData.numRows = data.playlists?.items?.count ?? 0
//                    self.updateClosure?()
//                case .failure(let error):
//                    print("Custom Error -> \(error)")
//            }
//        }
//    }
    func getPlaylists() {
        for urls in APIUrls.allCases {
//            let url = APIUrls.relax.url
            APIService.getData(Toplist.self, url: urls.url) { result in
                switch result {
                    case .success(let data):
                        self.mainPageData.playlists.append(data)
                        self.mainPageData.numRows.append(data.playlists?.items?.count ?? 0) 
                        self.updateClosure?()
                    case .failure(let error):
                        print("Custom Error -> \(error)")
                }
            }
        }
    }
    
    func start() {
        let headerCell = HeaderTableViewCell()
        headerCell.delegate = self
//        getToplist()
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
    func cleanKeychain() {
//        LoginManager.shared.deleteAll()
//        KeychainManager.logout(for: KeychainConstants.accessToken.key)
        guard let wrongToken = "".data(using: .utf8) else { return }
        do {
            _ = try KeychainManager.logout(for: KeychainConstants.accessToken.key)
            _ = try KeychainManager.save(token: wrongToken, tokenKey: KeychainConstants.accessToken.key)
        } catch {
            print(error)
        }
    }
}
