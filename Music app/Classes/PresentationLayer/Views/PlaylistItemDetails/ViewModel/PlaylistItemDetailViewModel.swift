import Foundation
protocol PlaylistItemDetailViewModelProtocol {
    func start()
    func getItems()
    var details: String { get set }
    var playlist: PlaylistModel { get }
    var updateClosure:(() -> Void)? { get set }
    func playButtonAction()
    func addPlayItems(itemIndex: Int)
    var isPlaying: Bool { get set }
}

final class PlaylistItemDetailViewModel: PlaylistItemDetailViewModelProtocol, AudioPlayerDelegateForDetails, TrackItemDetailTableViewCellDelegate {
    
    var coordinator: MainPageCoordinator?
    var id: String?
    var playingThisPlaylist: Bool = false
    var details: String = "" {
        didSet {
            updateClosure?()
        }
    }
    
    var isPlaying: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    var updateClosure: (() -> Void)?
    var cleared = false
    var playlist: PlaylistModel = PlaylistModel() {
        didSet {
            if cleared == false {
                removeNilSongs()
                cleared = true
            }
            updateClosure?()
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
    func start() {
        let trackDetailsCell = TrackItemDetailTableViewCell()
        trackDetailsCell.delegate = self
        updateClosure?()
    }
    
    func addPlayItems(itemIndex: Int) {
        var playerPlaylist: [PlayerItemModel] = []
        playlist.tracks?.items?.forEach { item in
            guard let url = item.track?.preview_url else { return }
            guard let imageUrl = item.track?.album?.images?.first?.url else { return }
            guard let trackName = item.track?.name else { return }
            guard let artistName = item.track?.artists?.first?.name else { return }
            let playerItem = PlayerItemModel(url: url, image: imageUrl, trackName: trackName, artistName: artistName)
            playerPlaylist.append(playerItem)
        }
        AudioPlayerService.shared.addPlaylistForPlayer(playerPlaylist, itemIndex: itemIndex)
        playingThisPlaylist = true
    }
    
    func getItems() {
        guard let id = id else { return }
        let url = NetworkConstants.baseUrl + NetworkConstants.playlists + (id)
        APIService.getData(PlaylistModel.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.playlist = data
                    self.details = data.description ?? ""
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
        
    }
    
    func playButtonAction() {
        if AudioPlayerService.shared.playerItem.isEmpty || playingThisPlaylist == false {
            addPlayItems(itemIndex: 0)
        } else {
            AudioPlayerService.shared.playPause()
        }
    }
    
    func addToPlaylist(trackId: String) {
        playlist.tracks?.items?.forEach{ item in
            if item.track?.id == trackId {
                guard let artistName = item.track?.artists?.first?.name,
                      let trackName = item.track?.name,
                      let image = item.track?.album?.images?.first?.url,
                      let track = item.track?.preview_url
                else { return }
                let trackItem = UserPlaylistTrack(artistName: artistName, trackName: trackName, image: image, trackID: track)
                coordinator?.showAddToPlaylist(trackItem: trackItem)
            }
        }
    }
    
    func removeNilSongs() {
        guard let id = id else { return }
        var indexArray: [String] = []
        playlist.tracks?.items?.forEach { item in
            if item.track?.preview_url == nil {
                guard let id = item.track?.id else { return }
                indexArray.append(id)
            }
        }
        indexArray.forEach { id in
            guard let itemsArray = playlist.tracks?.items else { return }
            for (i, v) in itemsArray.enumerated() {
                if id == v.track?.id {
                    playlist.tracks?.items?.remove(at: i)
                }
            }
        }
    }
    
}

