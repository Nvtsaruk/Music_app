import Foundation
protocol ItemDetailViewModelProtocol {
    func getItems()
    var details: String { get set }
    var playlist: PlaylistModel { get }
    var updateClosure:(() -> Void)? { get set }
}

final class ItemDetailViewModel: ItemDetailViewModelProtocol {
    var coordinator: MainPageCoordinator?
    var id: String?
    var details: String = "Details" {
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
    
    
    func getItems() {
        let url = "https://api.spotify.com/v1/playlists/\(id ?? "")"
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
    func removeNilSongs() {
        var indexArray: [String] = []
        playlist.tracks?.items?.forEach { item in
            if item.track?.preview_url == nil {
                guard let id = item.track?.id else { return }
                indexArray.append(id)
            }
        }
        print(indexArray)
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
