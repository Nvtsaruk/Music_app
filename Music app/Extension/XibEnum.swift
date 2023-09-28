enum XibNames {
    case playlist
    
    var name: String {
        switch self {
            case .playlist:
                return "PlaylistTableViewCell"
            }
        }
}
