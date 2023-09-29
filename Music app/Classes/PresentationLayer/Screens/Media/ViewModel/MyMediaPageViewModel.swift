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
            updateClosure?()
        }
    }
    
    var playlist: PlaylistModel? {
        didSet {
            updateClosure?()
        }
    }
    
    func start() {
        DatabaseService.shared.addObserver(self)
        databasePlaylist = DatabaseService.shared.getPlaylists()
        updateClosure?()
    }

    private func getPlaylist(id: Int) {
        playlist = PlaylistModel(description: "", id: "", images: [ImageModel(url: "")], name: "", owner: PlaylistModelOwner(display_name: "", id: "", type: ""), tracks: PlaylistModelTracks(items: [PlaylistModelTracksItem(added_at: "",added_by: PlaylistModelTracksItemUser(id: "", type: ""), track: Track(album: TrackAlbum(album_type: "", artists: [TrackAlbumArtist(id: "", name: "", type: "")], id: "", images: [ImageModel(url: "")], name: "", release_date: "", type: ""), artists: [TrackAlbumArtist(id: "", name: "", type: "")], id: "", name: "", preview_url: "", type: ""))]), type: "")
        playlist?.name = databasePlaylist[id].playlistName
        print(databasePlaylist[id].playlistName)
        guard let imageURL = databasePlaylist[id].tracks.first?.image else { return }
        playlist?.images = [ImageModel(url: imageURL)]
        var tracksArray: [PlaylistModelTracksItem] = []
        databasePlaylist[id].tracks.forEach{ track in
            let trackID = track.trackID
            let trackImage = track.image
            let trackName = track.trackName
            let artistName = track.artistName
            let trackAlbum = TrackAlbum(album_type: "", artists: [TrackAlbumArtist(id: "", name: artistName, type: "")], id: "", images: [ImageModel(url: trackImage)], name: "", release_date: "", type: "")
            let track  = Track(album: trackAlbum, artists: [TrackAlbumArtist(id: "", name: artistName, type: "artist")], id: "", name: trackName, preview_url: trackID, type: "track")
            let playlistModelTracksItemUser = PlaylistModelTracksItemUser(id: "", type: "")
            let playlistModelTracksItem = PlaylistModelTracksItem(added_at: "",added_by: playlistModelTracksItemUser, track: track)
            tracksArray.append(playlistModelTracksItem)
        }
        
        let tracks = PlaylistModelTracks(items: tracksArray)
        playlist?.tracks = tracks
    }

    func showPlaylist(id: Int) {
        getPlaylist(id: id)
        guard let playlist = playlist else { return }
        coordinator?.showItemDetail(id: "", playlist: playlist)
    }
}

extension MyMediaPageViewModel: DatabaseServiceObserver {
    func dataBaseUpdated() {
        databasePlaylist = DatabaseService.shared.getPlaylists()
    }
    
    
}
