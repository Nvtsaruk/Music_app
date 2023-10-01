import Foundation

protocol MainPageViewModelProtocol {
    func logout()
    func getPlaylists()
    func start()
    func showItemDetail(id: String)
    var mainPageData: MainPageData { get }
    var updateClosure:( ()->Void )? { get set }
    var isLoading: Bool { get }
    func getDayTime() -> String
}

enum CellType {
    case header
    case topPlaylists
    case playlists
}

enum DayTime {
    case morning
    case afternoon
    case evening
    case night
    
    var greeting: String {
        switch self {
            case .morning:
                return MainScreenLocalization.morning.string
            case .afternoon:
                return MainScreenLocalization.afternoon.string
            case .evening:
                return MainScreenLocalization.evening.string
            case .night:
                return MainScreenLocalization.night.string
        }
    }
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
    
    private let hour = Calendar.current.component(.hour, from: Date())
    
    var mainPageData: MainPageData = MainPageData() {
        didSet {
            updateClosure?()
        }
    }
    
    func getDayTime() -> String {
        switch hour{
            case 6...11:
                return DayTime.morning.greeting
            case 12...17:
                return DayTime.afternoon.greeting
            case 18...24:
                return DayTime.evening.greeting
            default:
                return DayTime.night.greeting
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
                        ErrorHandler.shared.handleError(error: error)
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

