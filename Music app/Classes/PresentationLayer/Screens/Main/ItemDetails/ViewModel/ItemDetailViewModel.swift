import Foundation
protocol ItemDetailViewModelProtocol {
    func getItems()
    var details: String { get set }
    var playlist: PlaylistModel { get }
    var updateClosure:(() -> Void)? { get set }
    func playButtonAction()
    func addPlayItems(itemIndex: Int)
    var isPlaying: Bool { get set }
}

final class ItemDetailViewModel: ItemDetailViewModelProtocol, AudioPlayerDelegate {
    var coordinator: MainPageCoordinator?
    var id: String?
    var details: String = "Details" {
        didSet {
            updateClosure?()
        }
    }
    
    var isPlaying: Bool = false {
        didSet {
            print("Is playing model",isPlaying)
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
    
    func addPlayItems(itemIndex: Int) {
        AudioPlayerService.shared.addPlaylistForPlayer(playlist, itemIndex: itemIndex)
    }
    
    func getItems() {
        let url = NetworkConstants.baseUrl + NetworkConstants.playlists + (id ?? "")
        APIService.getData(PlaylistModel.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.playlist = data
                    self.details = data.description ?? ""
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
        AudioPlayerService.shared.delegate = self
    }
    
    func playButtonAction() {
        AudioPlayerService.shared.playPause()
    }
    
    func removeNilSongs() {
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
    deinit {
        print("deinit")
    }
}

