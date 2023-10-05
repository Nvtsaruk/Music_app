import RealmSwift
final class DatabaseService {
    static var shared = DatabaseService()
    private init() {}
    
    var observations = [ObjectIdentifier: Observation] ()
    
    let realm = try! Realm()
    
    func createPlaylist(userId: String, playlistName: String, item: UserPlaylistTrack) {
        let track = DatabaseTrack(item)
        let playlist = DatabasePlaylist()
        playlist.playlistName = playlistName
        playlist.playlistImage = item.image
        playlist.tracks.append(track)
        let user = DatabaseUser()
        user.userId = userId
        user.playlists.append(playlist)
        try! realm.write {
            realm.add(user)
        }
        baseDidChange()
    }
    
    func addToPlaylist(playlistName: String, item: UserPlaylistTrack) {
        let playlists = realm.objects(DatabaseUser.self)
        let userPlaylists = playlists.where {
            $0.playlists.playlistName == playlistName
        }
        let track = DatabaseTrack(item)
        userPlaylists.first?.playlists.forEach{ item in
            if item.playlistName == playlistName {
                try! realm.write {
                    item.tracks.append(track)
                }
            }
        }
        baseDidChange()
    }
    
    func getPlaylists() -> [UserPlaylist] {
        let playlists = realm.objects(DatabaseUser.self)
        var userPlaylistsArray: [UserPlaylist] = []
        playlists.forEach { item in
            var tracks: [UserPlaylistTrack] = []
            let playlistName = item.playlists.first?.playlistName
            item.playlists.first?.tracks.forEach { track in
                let playlistTrack = UserPlaylistTrack(artistName: track.artistName, trackName: track.trackName, image: track.image, trackID: track.trackId)
                tracks.append(playlistTrack)
            }
            let userPlaylist = UserPlaylist(playlistName: playlistName ?? "", tracks: tracks)
            userPlaylistsArray.append(userPlaylist)
        }
        return userPlaylistsArray
    }
    func deletePlaylist(playlistName: String) {
        try! realm.write {
            let playlist = realm.objects(DatabaseUser.self).where {
                $0.playlists.playlistName == playlistName
            }
            realm.delete(playlist)
        }
        let playlists = realm.objects(DatabaseUser.self)
        baseDidChange()
    }
}
