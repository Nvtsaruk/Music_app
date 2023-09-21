
import Foundation
protocol AlbumItemDetailViewModelProtocol {
    func getAlbumItems()
    var details: String { get set }
    var album: Album { get }
    var updateClosure:(() -> Void)? { get set }
    func playButtonAction()
        func addPlayItems(itemIndex: Int)
    var isPlaying: Bool { get set }
}

final class AlbumItemDetailViewModel: AlbumItemDetailViewModelProtocol, AudioPlayerDelegateForDetails {
    
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
    
    var updateClosure: (() -> Void)?
    var cleared = false
    var album: Album = Album() {
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
    
    func addPlayItems(itemIndex: Int) {
        var playerPlaylist: [PlayerItemModel] = []
        let image = album.images?.first?.url
        album.tracks.items.forEach { item in
            guard let url = item.preview_url,
                  let imageUrl = image,
                  let artistName = item.artists?.first?.name else { return }
            let trackName = item.name
            let playerItem = PlayerItemModel(url: url, image: imageUrl, trackName: trackName, artistName: artistName)
            playerPlaylist.append(playerItem)
        }
        AudioPlayerService.shared.addPlaylistForPlayer(playerPlaylist, itemIndex: itemIndex)
        playingThisPlaylist = true
    }
    
    func getAlbumItems() {
        let url = NetworkConstants.baseUrl + NetworkConstants.albums + (id ?? "")
        APIService.getData(Album.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.album = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
        AudioPlayerService.shared.detailsDelegate = self
    }
    
    func playButtonAction() {
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
        album.tracks.items.forEach { item in
            if item.preview_url == nil {
                indexArray.append(item.id)
                print(item.id)
            }
        }
        indexArray.forEach { id in
            for (i, v) in album.tracks.items.enumerated() {
                if id == v.id {
                    album.tracks.items.remove(at: i)
                }
            }
        }
    }
    
}

