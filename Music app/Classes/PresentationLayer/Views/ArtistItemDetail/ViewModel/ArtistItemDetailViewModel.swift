import Foundation
protocol ArtistItemDetailViewModelProtocol {
    var artist: Artist? { get }
    var topTracks: [Track] { get }
    func getArtistInfo()
    var updateClosure: (() -> Void)? { get set }
    func addPlayItems(itemIndex: Int)
    func playButtonAction()
    var isPlaying: Bool { get set }
}

final class ArtistItemDetailViewModel: ArtistItemDetailViewModelProtocol, AudioPlayerDelegateForDetails {
    
    
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
   
    
    func getArtistInfo() {
        let url = NetworkConstants.baseUrl + NetworkConstants.artists + (id ?? "")
        APIService.getData(Artist.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.artist = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
        
        AudioPlayerService.shared.detailsDelegate = self
    }
    func getArtistTracks() {
        let url = NetworkConstants.baseUrl + NetworkConstants.artists + (id ?? "") + NetworkConstants.topTracks
        APIService.getData(ArtistTopTrackModel.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.topTracks = data.tracks
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
        AudioPlayerService.shared.detailsDelegate = self
    }
    
    func addPlayItems(itemIndex: Int) {
        var playerPlaylist: [PlayerItemModel] = []
        topTracks.forEach { item in
            guard let url = item.preview_url else { return }
            guard let imageUrl = item.album?.images?.first?.url else { return }
            guard let artistName = item.artists?.first?.name else { return }
            let trackName = item.name
            let playerItem = PlayerItemModel(url: url, image: imageUrl, trackName: trackName, artistName: artistName)
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
    
    func audioPlayerDidStartPlaying() {
        isPlaying = true
    }
    
    func audioPlayerDidStopPlaying() {
        isPlaying = false
    }
    
    func sendTrackInfo(playerItem: PlayerItemModel) {
        
    }
}

