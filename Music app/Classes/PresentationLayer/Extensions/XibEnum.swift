enum XibNames {
    case playlist
    case playlists
    case myPlaylist
    case headerTableViewCell
    case trackItemDetailTableViewCell
    case playlistsCollectionViewCell
    case searchCollectionViewCell
    case albumTableViewCell
    case artistTableViewCell
    case topPlaylistTableViewCell
    case topPlaylistCollectionViewCell
    
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
            case .trackItemDetailTableViewCell:
                return "TrackItemDetailTableViewCell"
            case .playlistsCollectionViewCell:
                return "PlaylistsCollectionViewCell"
            case .searchCollectionViewCell:
                return "SearchCollectionViewCell"
            case .albumTableViewCell:
                return "AlbumTableViewCell"
            case .artistTableViewCell:
                return "ArtistTableViewCell"
            case .topPlaylistTableViewCell:
                return "TopPlaylistTableViewCell"
            case .topPlaylistCollectionViewCell:
                return "TopPlaylistCollectionViewCell"
        }
    }
}
