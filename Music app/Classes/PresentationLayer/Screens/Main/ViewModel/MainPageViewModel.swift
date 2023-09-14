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
    init(playlistNames: [String] = [], playlists: [Toplist]? = nil, numRows: [Int] = []) {
        self.playlistNames = playlistNames
        self.playlists = playlists ?? []
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
                        self.mainPageData.numRows.append(data.playlists?.items?.count ?? 0)
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
    func cleanKeychain() {
//        print("Clean")
        let right_Token = "BQD1qSeyAXA8AAtQagE5zlsKazoB7E1fmjnlAU8FcL5qx8BtfXluf7Eh3oqfw3v8hwsuQTxmdSkr9MzmZU0vVInwOTkMMbTum5rvA_rXLL4lmoj-5dH8-3UCnP-4gqwXvSxD8Ye3whV8ivk-NmihqsbSCeimaisjod7JAHjC8ZLYPxoItIz2Ba5LAF4HzMadHC7dtSK5T2owAaQjgDk2-R8a3z_EE5oU5hL3ISnFDAmxGnb_DwncCeSx5dg8OqcX8THR-uDi7JAcX2XLGyVpMxTCLCRcBe712iuTLffj-JsR-LkuZiF-zg"
        let wrongToken = "BQAreOfwnCKhvpsuOXzGNYrHzdUrLLNUaAZZsH8rBU1gvmhcPrNHNnjL6zs_c1tWkqHQF-yVYlaz5aOq5ez4ThR9gw2mEDDcAvgQrxhn7TY9Cf8Tl4nNxa5gCcX385a3N_OXSuz76uys4kGze7bsiW_I4Kb8CbvuGqq509k9UVbucwGXDrIjb8J7bNaoHncpkJN7EYmMBXA3JCDK9si6qyeZkHy4nZ7J616K354RJlII-W-_YS-gOGY4XepyyzZo4wMDjoKLQjFkiUiYgejAUMzWJKfUryrAA4agoRK855UQTI9-YwElZe"
//        KeychainManager().logout(for: KeychainConstants.accessToken.key)
        do {
            _ = try CredentialStorageService().logout(for: KeychainConstants.accessToken.key)
        } catch {
            print(error)
        }
        guard let accessToken = wrongToken.data(using: .utf8) else { return }
        CredentialStorageService().saveAccessToken(token: accessToken)
//        KeychainManager().save(token: accessToken, tokenKey: KeychainConstants.accessToken.key)
//        do {
//            guard let accessToken = wrongToken.data(using: .utf8) else { return }
//            _ = try CredentialStorageService().save(token: accessToken, tokenKey: KeychainConstants.accessToken.key)
//        } catch {
//            print(error)
//        }
//        let temp = try KeychainManager().getPassword(for: KeychainConstants.accessToken.key)
//        print("token after reset", String(decoding: temp ?? Data(), as: UTF8.self))
        do {
            let temp = try CredentialStorageService().getPassword(for: KeychainConstants.accessToken.key)
            print("token after reset", String(decoding: temp ?? Data(), as: UTF8.self))
        } catch {
            print(error)
        }
        
    }
    
    
}

