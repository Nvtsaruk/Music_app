import Foundation

protocol MainPageViewModelProtocol {
    func logout()
    func getPLaylists()
    func getNewRelises()
    func start()
    var mainPageData: NewReleasesPlaylist { get }
    var updateClosure:( ()->Void )? { get set }
}
struct NewReleasesPlaylist {
    var newReleases: NewReleases
    var numRows: Int
}


final class MainPageViewModel: MainPageViewModelProtocol {
  
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    
    var mainPageData: NewReleasesPlaylist = NewReleasesPlaylist(newReleases: NewReleases(albums: Albums(items: [Album(album_type: "", id: "", images: [ImageModel(url: "")], name: "", release_date: "", total_tracks: 0, artists: [Artist(id: "", name: "", type: "")])])), numRows: 0) {
        didSet {
            updateClosure?()
        }
    }
    
    func getNewRelises() {
        let url = "https://api.spotify.com/v1/browse/new-releases?limit=50&country=SE"
        APIService.getData(NewReleases.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.mainPageData.newReleases = data
                    self.mainPageData.numRows = data.albums.items.count
                    print("NumROWS:", self.mainPageData.numRows)
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func start() {
        let headerCell = HeaderTableViewCell()
        headerCell.delegate = self
    }
    
    func logout() {
        LoginManager.shared.deleteAll()
    }
    func getPLaylists() {
//        APIService.getPlaylist()
    }
}
//
extension MainPageViewModel: HeaderTableViewCellDelegate {
    func goToUserProfile() {
        coordinator?.goToUserProfile()
    }
}
