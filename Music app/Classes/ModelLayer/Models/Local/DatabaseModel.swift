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
