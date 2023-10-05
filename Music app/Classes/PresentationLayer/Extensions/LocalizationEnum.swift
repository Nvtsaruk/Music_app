import Foundation

enum ProfileLocalization {
    case myProfile
    case logout
    case plan
    case email
    case userID
    case country
    
    var string: String {
        switch self {
            case .myProfile:
                return NSLocalizedString("myProfile", comment: "")
            case .logout:
                return NSLocalizedString("logout", comment: "")
            case .plan:
                return NSLocalizedString("plan", comment: "")
            case .email:
                return NSLocalizedString("email", comment: "")
            case .userID:
                return NSLocalizedString("userID", comment: "")
            case .country:
                return NSLocalizedString("country", comment: "")
        }
    }
}

enum MainScreenLocalization {
    case topList
    case relax
    case pop
    case rock
    case mood
    case main
    case search
    case media
    case morning
    case afternoon
    case evening
    case night
    
    var string: String {
        switch self {
            case .topList:
                return NSLocalizedString("topList", comment: "")
            case .relax:
                return NSLocalizedString("relax", comment: "")
            case .pop:
                return NSLocalizedString("pop", comment: "")
            case .rock:
                return NSLocalizedString("rock", comment: "")
            case .mood:
                return NSLocalizedString("mood", comment: "")
            case .main:
                return NSLocalizedString("main", comment: "")
            case .search:
                return NSLocalizedString("search", comment: "")
            case .media:
                return NSLocalizedString("media", comment: "")
            case .morning:
                return NSLocalizedString("morning", comment: "")
            case .afternoon:
                return NSLocalizedString("afternoon", comment: "")
            case .evening:
                return NSLocalizedString("evening", comment: "")
            case .night:
                return NSLocalizedString("night", comment: "")
        }
    }
}

enum SearchPageLocalization {
    case track
    case artist
    case album
    case playlist
    case searchbarPlaceholder
    
    var string: String {
        switch self {
            case .track:
                return NSLocalizedString("track", comment: "")
            case .artist:
                return NSLocalizedString("artist", comment: "")
            case .album:
                return NSLocalizedString("album", comment: "")
            case .playlist:
                return NSLocalizedString("playlist", comment: "")
            case .searchbarPlaceholder:
                return NSLocalizedString("searchbarPlaceholder", comment: "")
        }
    }
}

enum MyMediaLocalization {
    case myPlaylists
    case emptyPlaylists
    
    var string: String {
        switch self {
            case .myPlaylists:
                return NSLocalizedString("myPlaylists", comment: "")
            case .emptyPlaylists:
                return NSLocalizedString("emptyPlaylists", comment: "")
        }
    }
}

enum AddToPlaylistLocalization {
    case createPlaylist
    case ready
    case playlistName
    case message
    case placeholder
    case cancel
    
    var string: String {
        switch self {
            case .createPlaylist:
                return NSLocalizedString("createPlaylist", comment: "")
            case .ready:
                return NSLocalizedString("ready", comment: "")
            case .playlistName:
                return NSLocalizedString("playlistName", comment: "")
            case .message:
                return NSLocalizedString("message", comment: "")
            case .placeholder:
                return NSLocalizedString("placeholder", comment: "")
            case .cancel:
                return NSLocalizedString("cancel", comment: "")
        }
    }
}
