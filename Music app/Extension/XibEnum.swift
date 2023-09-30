enum XibNames {
    case playlist
    case myPlaylist
    
    var name: String {
        switch self {
            case .playlist:
                return "PlaylistTableViewCell"
            case .myPlaylist:
                return "MyPlaylistTableViewCell"
            }
        }
}
