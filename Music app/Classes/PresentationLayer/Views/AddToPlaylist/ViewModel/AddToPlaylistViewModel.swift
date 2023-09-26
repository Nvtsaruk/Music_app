protocol AddToPlaylistViewModelProtocol {
    func start()
    func createPlaylist(playlistName: String)
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
    var currentUser: UserProfile = UserProfile() {
        didSet {
            print(currentUser.display_name)
        }
    }
    
    var playlist: [UserPlaylist] = [] {
        didSet {
            print("Playlist", playlist)
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
        let userId = currentUser.id
        guard let trackItem = trackItem else { return }
        DatabaseService.shared.createPlaylist(userId: userId, playlistName: playlistName, item: trackItem)
    }
    
    func selectedPlaylist(id: Int) {
        let playlistName = playlist[id].playlistName
        guard let trackItem = trackItem else { return }
        DatabaseService.shared.addToPlaylist(playlistName: playlistName, item: trackItem)
    }

    func cancel() {
        DatabaseService.shared.deletePlaylist()
    }
}
