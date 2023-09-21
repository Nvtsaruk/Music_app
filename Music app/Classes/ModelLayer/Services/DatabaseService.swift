import RealmSwift

class DatabasePlaylistModel: Object {
    @Persisted var name: String
    @Persisted var trackId: String
    
    convenience init(name: String, trackId: String) {
        self.init()
        self.name = name
        self.trackId = trackId
    }
}

final class DatabaseService {
    static var shared = DatabaseService()
    private init() {}
    
    func savePlaylist(userId: String, id: String, name: String) {
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(userId)
        config.fileURL!.appendPathExtension("realm")
        let realm = try! Realm(configuration: config)
        
        let playlistTemp = DatabasePlaylistModel(name: name, trackId: id)
        
        try! realm.write {
            realm.add(playlistTemp)
        }
    }
}
