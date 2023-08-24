enum NetworkConstants {
    static let redirectURI = "https://igly.by"
    static let baseAPICodeUrl = "https://accounts.spotify.com/authorize"
    static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
    static let baseUrl = "https://api.spotify.com/v1/"
    static let userProfileUrl = NetworkConstants.baseUrl + "me"
    static let requestSettings = "?country=BY&offset=0&limit=50"
    static let categories = "browse/categories/"
}

enum APIUrls: CaseIterable {
    case topPlaylists
//    case featuredPlaylists
    case relax
    case pop
    case rock
    case training
    
    var url: String {
        switch self {
            case .topPlaylists:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "toplists/playlists" + NetworkConstants.requestSettings
//            case .featuredPlaylists:
//                return NetworkConstants.baseUrl + NetworkConstants.categories + "featured-playlists" + NetworkConstants.requestSettings
            case .relax:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFFzDl7qN9Apr/playlists" + NetworkConstants.requestSettings
            case .pop:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFEC4WFtoNRpw/playlists" + NetworkConstants.requestSettings
            case .rock:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFDXXwE9BDJAr/playlists" + NetworkConstants.requestSettings
            case .training:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFAXlCG6QvYQ4/playlists" + NetworkConstants.requestSettings
        }
    }
    
}

