import RealmSwift

class DatabaseUser: Object {
    @Persisted var userId: String
    @Persisted var playlists: List<DatabasePlaylist>
    
    convenience init(userId: String, playlist: List<DatabasePlaylist>) {
        self.init()
        self.userId = userId
        self.playlists = playlist
    }
}

class DatabasePlaylist: Object {
    @Persisted var playlistName: String
    @Persisted var playlistImage: String
    @Persisted var tracks: List<DatabaseTrack>
    
    convenience init(playlistName: String, playlistImage: String,tracks: List<DatabaseTrack>) {
        self.init()
        self.playlistName = playlistName
        self.playlistImage = playlistImage
        self.tracks = tracks
    }
}

class DatabaseTrack: Object {
    @Persisted var artistName: String
    @Persisted var trackName: String
    @Persisted var image: String
    @Persisted var trackId: String
    
    convenience init(_ model: UserPlaylistTrack) {
        self.init()
        self.artistName = model.artistName
        self.trackName = model.trackName
        self.image = model.image
        self.trackId = model.trackID
    }
}

struct UserPlaylist {
    var playlistName: String
    var tracks: [UserPlaylistTrack]
}
struct UserPlaylistTrack {
    var artistName: String
    var trackName: String
    var image: String
    var trackID: String
    
    init(artistName: String, trackName: String, image: String, trackID: String) {
        self.artistName = artistName
        self.trackName = trackName
        self.image = image
        self.trackID = trackID
    }
    init() {
        self.artistName = ""
        self.trackName = ""
        self.image = ""
        self.trackID = ""
    }
}

final class DatabaseService {
    static var shared = DatabaseService()
    private init() {}
    
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
    }
    
    func getPlaylists() -> [UserPlaylist] {
        let playlists = realm.objects(DatabaseUser.self)
//        let userPlaylists = playlists.where {
//            $0.userId == "31rxgvo6ng6ry35wjsoes7xrzspa"
//        }
        var userPlaylistsArray: [UserPlaylist] = []
        playlists.forEach { item in
            var tracks: [UserPlaylistTrack] = []
            var playlistTrack = UserPlaylistTrack()
            let playlistName = item.playlists.first?.playlistName
            item.playlists.first?.tracks.forEach { track in
                playlistTrack.artistName = track.artistName
                playlistTrack.image = track.image
                playlistTrack.trackID = track.trackId
                playlistTrack.trackName = track.trackName
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
        print(playlists.count)
    }
}
