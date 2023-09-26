import Foundation
protocol SearchPageViewModelProtocol {
    func start()
    func search(item: String)
    var searchModel: SearchResults { get }
    var updateClosure:( ()->Void )? { get set }
    func backToSearchCategories()
    func showPlaylistDetail(id: String)
    func showArtistDetail(id: String)
    func showAlbumDetail(id: String)
}

final class SearchPageViewModel: SearchPageViewModelProtocol, TrackItemDetailTableViewCellDelegate {
    
    
    
    
    var coordinator: SearchPageCoordinator?
    var lastScheduledSearch: Timer?
    
    var updateClosure: (() -> Void)?
    var cleared = false
    var searchModel: SearchResults = SearchResults() {
        didSet {
            if cleared == false {
                removeNilSongs()
                cleared = true
            }
            print(searchModel.tracks.items.count)
            updateClosure?()
        }
    }
    
    func start() {
        let trackDetailsCell = TrackItemDetailTableViewCell()
        trackDetailsCell.delegate = self
    }
    
    func search(item: String) {
        lastScheduledSearch?.invalidate()
        lastScheduledSearch = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchQuery(_:)), userInfo: item, repeats: false)
        
    }
    
    func addToPlaylist(trackId: String) {
        searchModel.tracks.items.forEach{ item in
            if item.id == trackId {
                guard let artistName = item.artists.first?.name,
                      let image = item.album.images?.first?.url
                else { return }
                let trackName = item.name
                let track = item.id
                let trackItem = UserPlaylistTrack(artistName: artistName, trackName: trackName, image: image, trackID: track)
                coordinator?.showAddToPlaylist(trackItem: trackItem)
            }
        }
        
    }
    
    @objc private func searchQuery(_ timer: Timer) {
        guard let text = timer.userInfo else { return }
        let url = NetworkConstants.baseUrl + NetworkConstants.search + ((text as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        APIService.getData(SearchResults.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.searchModel = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    func removeNilSongs() {
        var indexArray: [String] = []
        searchModel.tracks.items.forEach { item in
            if item.preview_url == nil {
                indexArray.append(item.id)
            }
        }
        indexArray.forEach { id in
            for (i, v) in searchModel.tracks.items.enumerated() {
                if id == v.id {
                    searchModel.tracks.items.remove(at: i)
                }
            }
        }
    }
    
    func showPlaylistDetail(id: String) {
        coordinator?.showPlaylistDetail(id: id)
    }
    
    func showArtistDetail(id: String) {
        coordinator?.showArtistDetail(id: id)
    }
    
    func showAlbumDetail(id: String) {
        coordinator?.showAlbumDetail(id: id)
    }
    
    func backToSearchCategories() {
        coordinator?.popToRoot()
    }

}
