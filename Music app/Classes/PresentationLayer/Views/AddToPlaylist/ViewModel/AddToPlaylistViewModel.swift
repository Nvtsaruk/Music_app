protocol AddToPlaylistViewModelProtocol {
    func start()
    func createPlaylist(playlistName: String)
    func deletePlaylist(playlistIndex: Int)
    func cancel()
    var playlist: [UserPlaylist] { get }
    var updateClosure:(() -> Void)? { get set }
    func selectedPlaylist(id: Int)
}

final class AddToPlaylistViewModel: AddToPlaylistViewModelProtocol {
    var coordinator: SearchPageCoordinator?
    var trackItem: UserPlaylistTrack? {
        didSet {
            updateClosure?()
        }
    }
    var trackImage: String = ""
    var updateClosure: (() -> Void)?
    var currentUser: UserProfile = UserProfile()
    
    var playlist: [UserPlaylist] = [] {
        didSet {
            updateClosure?()
        }
    }
    
    func start() {
        getUserInfo()
        playlist = DatabaseService.shared.getPlaylists()
    }
    
    func getUserInfo() {
        let url = NetworkConstants.userProfileUrl
        APIService.getData(UserProfile.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.currentUser = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func createPlaylist(playlistName: String) {
        print(playlistName)
        let userId = currentUser.id
        guard let trackItem = trackItem else { return }
        DatabaseService.shared.createPlaylist(userId: userId, playlistName: playlistName, item: trackItem)
        updatePlaylists()
    }
    func updatePlaylists() {
        playlist = DatabaseService.shared.getPlaylists()
    }
    
    func selectedPlaylist(id: Int) {
        let playlistName = playlist[id].playlistName
        guard let trackItem = trackItem else { return }
        DatabaseService.shared.addToPlaylist(playlistName: playlistName, item: trackItem)
        updatePlaylists()
    }
    
    func deletePlaylist(playlistIndex: Int) {
        let playlistName = playlist[playlistIndex].playlistName
        playlist.remove(at: playlistIndex)
        DatabaseService.shared.deletePlaylist(playlistName: playlistName)
    }

    func cancel() {
       
    }
}
