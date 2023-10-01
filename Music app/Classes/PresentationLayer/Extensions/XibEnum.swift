enum XibNames {
    case playlist
    case playlists
    case myPlaylist
    case headerTableViewCell
    
    var name: String {
        switch self {
            case .playlist:
                return "PlaylistTableViewCell"
            case .playlists:
                return "PlaylistsTableViewCell"
            case .myPlaylist:
                return "MyPlaylistTableViewCell"
            case .headerTableViewCell:
                return "HeaderTableViewCell"
            }
        }
}
