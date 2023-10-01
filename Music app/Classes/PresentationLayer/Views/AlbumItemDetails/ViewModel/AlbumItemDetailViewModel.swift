
import Foundation
protocol AlbumItemDetailViewModelProtocol {
    var details: String { get set }
    var album: Album? { get }
    var updateClosure:(() -> Void)? { get set }
    var isPlaying: Bool { get set }
    var isLoading: Bool { get }
    func playButtonAction()
    func addPlayItems(itemIndex: Int)
    func start()
    func getAlbumItems()
}

final class AlbumItemDetailViewModel: AlbumItemDetailViewModelProtocol, TrackItemDetailTableViewCellDelegate {

    var coordinator: SearchPageCoordinator?
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
    
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    var updateClosure: (() -> Void)?
    var cleared = false
    var album: Album? {
        didSet {
            if cleared == false {
                removeNilSongs()
                cleared = true
            }
            updateClosure?()
        }
    }
    
    func addToPlaylist(trackId: String) {
        guard let album = album else { return }
        guard let image = album.images.first?.url else { return }
        album.tracks.items.forEach{ item in
            if item.id == trackId {
                guard let artistName = item.artists.first?.name
                else { return }
                let trackName = item.name
                let track = item.id
                let trackItem = UserPlaylistTrack(artistName: artistName, trackName: trackName, image: image, trackID: track)
                coordinator?.showAddToPlaylist(trackItem: trackItem)
            }
        }
        
    }
    
    func start() {
        AudioPlayerService.shared.addObserver(self)
        let trackItem = TrackItemDetailTableViewCell()
        trackItem.delegate = self
    }
    func addPlayItems(itemIndex: Int) {
        var playerPlaylist: [PlayerItemModel] = []
        let image = album?.images.first?.url
        guard let album = album else { return }
        album.tracks.items.forEach { item in
            guard let url = item.preview_url,
                  let imageUrl = image,
                  let artistName = item.artists.first?.name else { return }
            let trackName = item.name
            let playerItem = PlayerItemModel(url: url, imageURL: imageUrl, trackName: trackName, artistName: artistName)
            playerPlaylist.append(playerItem)
        }
        AudioPlayerService.shared.addPlaylistForPlayer(playerPlaylist, itemIndex: itemIndex)
        playingThisPlaylist = true
    }
    
    func getAlbumItems() {
        isLoading = true
        let url = NetworkConstants.baseUrl + NetworkConstants.albums + (id ?? "")
        APIService.getData(Album.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.album = data
                case .failure(let error):
                    ErrorHandler.shared.handleError(error: error)
            }
        }
        
    }
    
    func playButtonAction() {
        guard let album = album else { return }
        if !album.tracks.items.isEmpty {
            if AudioPlayerService.shared.playerItem.isEmpty || playingThisPlaylist == false {
                addPlayItems(itemIndex: 0)
            } else {
                AudioPlayerService.shared.playPause()
            }
        }
    }
    
    func removeNilSongs() {
        var indexArray: [String] = []
        album?.tracks.items.forEach { item in
            if item.preview_url == nil {
                indexArray.append(item.id)
            }
        }
        indexArray.forEach { id in
            guard let enumeratedAlbum = album else { return }
            for (i, v) in enumeratedAlbum.tracks.items.enumerated() {
                if id == v.id {
                    album?.tracks.items.remove(at: i)
                }
            }
        }
    }
    
}

extension AlbumItemDetailViewModel: AudioPlayerServiceObserver {
    func audioPlayerPlaying(item: PlayerItemModel) {
        isPlaying = true
    }
    
    func audioPlayerPaused(item: PlayerItemModel) {
        isPlaying = false
    }
    
}
