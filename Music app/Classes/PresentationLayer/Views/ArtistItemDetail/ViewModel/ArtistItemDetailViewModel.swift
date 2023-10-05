import Foundation
protocol ArtistItemDetailViewModelProtocol {
    var isPlaying: Bool { get set }
    var artist: Artist? { get }
    var topTracks: [Track] { get }
    var updateClosure: (() -> Void)? { get set }
    var isLoading: Bool { get }
    func start()
    func getArtistInfo()
    func addPlayItems(itemIndex: Int)
    func playButtonAction()
    
}

final class ArtistItemDetailViewModel: ArtistItemDetailViewModelProtocol, TrackItemDetailTableViewCellDelegate {
    func start() {
        AudioPlayerService.shared.addObserver(self)
    }
    
    var updateClosure: (() -> Void)?
    var coordinator: SearchPageCoordinator?
    var id: String?
    var playingThisPlaylist: Bool = false
    var isPlaying: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    var artist: Artist? {
        didSet {
            updateClosure?()
            getArtistTracks()
        }
    }
    var cleared = false
    var topTracks: [Track] = [] {
        didSet {
            if cleared == false {
                removeNilSongs()
                cleared = true
            }
            updateClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    func addToPlaylist(trackId: String) {
        topTracks.forEach{ item in
            if item.id == trackId {
                guard let artistName = item.artists.first?.name,
                      let image = item.album.images.first?.url
                else { return }
                let trackName = item.name
                let track = item.preview_url
                let trackItem = UserPlaylistTrack(artistName: artistName, trackName: trackName, image: image, trackID: track ?? "")
                coordinator?.showAddToPlaylist(trackItem: trackItem)
            }
        }
    }
    
    func getArtistInfo() {
        isLoading = true
        let url = NetworkConstants.baseUrl + NetworkConstants.artists + (id ?? "")
        APIService.getData(Artist.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.artist = data
                case .failure(let error):
                    ErrorHandler.shared.handleError(error: error)
            }
        }
    }
    func getArtistTracks() {
        isLoading = true
        let url = NetworkConstants.baseUrl + NetworkConstants.artists + (id ?? "") + NetworkConstants.topTracks
        APIService.getData(ArtistTopTrackModel.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.topTracks = data.tracks
                case .failure(let error):
                    ErrorHandler.shared.handleError(error: error)
            }
        }
    }
    
    func addPlayItems(itemIndex: Int) {
        var playerPlaylist: [PlayerItemModel] = []
        topTracks.forEach { item in
            guard let url = item.preview_url else { return }
            guard let imageUrl = item.album.images.first?.url else { return }
            guard let artistName = item.artists.first?.name else { return }
            let trackName = item.name
            let playerItem = PlayerItemModel(url: url, imageURL: imageUrl, trackName: trackName, artistName: artistName)
            playerPlaylist.append(playerItem)
        }
        AudioPlayerService.shared.addPlaylistForPlayer(playerPlaylist, itemIndex: itemIndex)
        playingThisPlaylist = true
    }
    
    func removeNilSongs() {
        var indexArray: [String] = []
        topTracks.forEach { item in
            if item.preview_url == nil {
                indexArray.append(item.id)
            }
        }
        indexArray.forEach { id in
            for (i, v) in topTracks.enumerated() {
                if id == v.id {
                    topTracks.remove(at: i)
                }
            }
        }
    }
    
    func playButtonAction() {
        if !topTracks.isEmpty {
            if AudioPlayerService.shared.playerItem.isEmpty || playingThisPlaylist == false {
                addPlayItems(itemIndex: 0)
            } else {
                AudioPlayerService.shared.playPause()
            }
        }
    }

}

extension ArtistItemDetailViewModel: AudioPlayerServiceObserver {
    func audioPlayerPlaying(item: PlayerItemModel) {
        isPlaying = true
    }
    
    func audioPlayerPaused(item: PlayerItemModel) {
        isPlaying = false
    }
}
