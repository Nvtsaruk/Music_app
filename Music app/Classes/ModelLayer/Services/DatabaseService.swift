import RealmSwift

final class DatabaseUser: Object {
    @Persisted var userId: String
    @Persisted var playlists: List<DatabasePlaylist>
    
    convenience init(userId: String, playlist: List<DatabasePlaylist>) {
        self.init()
        self.userId = userId
        self.playlists = playlist
    }
}

final class DatabasePlaylist: Object {
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

final class DatabaseTrack: Object {
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
}

protocol DatabaseServiceObserver: AnyObject {
    func dataBaseUpdated()
}



final class DatabaseService {
    static var shared = DatabaseService()
    private init() {}
    
    private var observations = [ObjectIdentifier: Observation] ()
    
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
//        let userPlaylists = playlists.where {
//            $0.userId == "31rxgvo6ng6ry35wjsoes7xrzspa"
//        }
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
        print(playlists.count)
        baseDidChange()
    }
}

private extension DatabaseService {
    struct Observation {
        weak var observer: DatabaseServiceObserver?
    }
}

private extension DatabaseService {
    func baseDidChange() {
        for (id, observation) in observations {
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            observer.dataBaseUpdated()
        }
    }
}

extension DatabaseService {
    func addObserver(_ observer: DatabaseServiceObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removeObserver(_ observer: DatabaseServiceObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
