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

    func getPlaylists() {
        for urls in APIUrls.allCases {
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
        print("Clean")
        let right_Token = "BQD1qSeyAXA8AAtQagE5zlsKazoB7E1fmjnlAU8FcL5qx8BtfXluf7Eh3oqfw3v8hwsuQTxmdSkr9MzmZU0vVInwOTkMMbTum5rvA_rXLL4lmoj-5dH8-3UCnP-4gqwXvSxD8Ye3whV8ivk-NmihqsbSCeimaisjod7JAHjC8ZLYPxoItIz2Ba5LAF4HzMadHC7dtSK5T2owAaQjgDk2-R8a3z_EE5oU5hL3ISnFDAmxGnb_DwncCeSx5dg8OqcX8THR-uDi7JAcX2XLGyVpMxTCLCRcBe712iuTLffj-JsR-LkuZiF-zg"
        let wrongToken = "BQD1qSeyAXA8AAtQagE5zlsKazoB7E1fmjnlAU8FcL5qx8BtfXluf7Eh3oqfw3v8hwsuQTxmdSkr9MzmZU0vVInwOTkMMbTum5rvA_rXLL4lmoj-5dH8-3UCnP-4gqwXvSxD8Ye3whV8ivk-NmihqsbSCeimaisjod7JAHjC8ZLYPxoItIz2Ba5LAF4HzMadHC7dtSK5T2owAaQjgDk2-R8a3z_EE5oU5hL3ISnFDAmxGnb_DwncCeSx5dg8OqcX8THR-uDi7JAcX2XLGyVpMxTCLCRcBe712iuTLffj-JsR-LkuZiF-yr"
        do {
            _ = try KeychainManager.logout(for: KeychainConstants.accessToken.key)
        } catch {
            print(error)
        }
        
        do {
            guard let accessToken = wrongToken.data(using: .utf8) else { return }
            _ = try KeychainManager.save(token: accessToken, tokenKey: KeychainConstants.accessToken.key)
        } catch {
            print(error)
        }
        do {
            let temp = try KeychainManager.getPassword(for: KeychainConstants.accessToken.key)
            print("token after reset", String(decoding: temp ?? Data(), as: UTF8.self))
        } catch {
            print(error)
        }
        
    }
    
    
}

