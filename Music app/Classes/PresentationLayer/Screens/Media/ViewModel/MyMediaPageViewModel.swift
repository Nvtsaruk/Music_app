import Foundation
protocol MyMediaPageViewModelProtocol {
    func start()
    var updateClosure:(() -> Void)? { get set }
    var databasePlaylist: [UserPlaylist] { get }
    func showPlaylist(id: Int)
}

final class MyMediaPageViewModel: MyMediaPageViewModelProtocol {
    var coordinator: MyMediaPageCoordinator?
    var updateClosure: (() -> Void)?
    var databasePlaylist: [UserPlaylist] = [] {
        didSet {
            print("database", databasePlaylist)
            updateClosure?()
        }
    }
    
    var playlist: PlaylistModel = PlaylistModel() {
        didSet {
//            if cleared == false {
//                removeNilSongs()
//                cleared = true
//            }
            updateClosure?()
        }
    }
    
    func start() {
        databasePlaylist = DatabaseService.shared.getPlaylists()
        updateClosure?()
    }

    private func getPlaylist(id: Int) {
        playlist.name = databasePlaylist[id].playlistName
        guard let imageURL = databasePlaylist[id].tracks.first?.image else { return }
        playlist.images = [ImageModel(url: imageURL)]
        var tracksArray: [PlaylistModelTracksItem] = []
        databasePlaylist[id].tracks.forEach{ track in
            let trackID = track.trackID
            let trackImage = track.image
            let trackName = track.trackName
            let artistName = track.artistName
            let track = PlaylistModelTracksItem(track: Track(album: TrackAlbum(images: [ImageModel(url: trackImage)]),artists: [TrackAlbumArtist(name: artistName)], id: "", name: trackName, preview_url: trackID, type: "track"))
            tracksArray.append(track)
        }
        
        let tracks = PlaylistModelTracks(total: 0, items: tracksArray)
        playlist.tracks = tracks
    }

    func showPlaylist(id: Int) {
        getPlaylist(id: id)
        
        coordinator?.showItemDetail(id: "", playlist: playlist)
    }
}
