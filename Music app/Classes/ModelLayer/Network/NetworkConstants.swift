enum NetworkConstants {
    static let redirectURI = "https://igly.by"
    static let baseAPICodeUrl = "https://accounts.spotify.com/authorize"
    static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
    static let baseUrl = "https://api.spotify.com/v1/"
    static let userProfileUrl = NetworkConstants.baseUrl + "me"
    static let requestSettings = "?country=BY&offset=0&limit=50"
    static let categories = "browse/categories/"
    static let playlists = "playlists/"
    static let artists = "artists/"
    static let albums = "albums/"
    static let search = "search?limit=5&type=album,artist,playlist,track&q="
    static let topTracks = "/top-tracks?market=ES"
}

enum APIUrls: CaseIterable {
    case topPlaylists
    case relax
    case pop
    case rock
    case mood
    
    var url: String {
        switch self {
            case .topPlaylists:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "toplists/playlists" + NetworkConstants.requestSettings
            case .relax:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFFzDl7qN9Apr/playlists" + NetworkConstants.requestSettings
            case .pop:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFEC4WFtoNRpw/playlists" + NetworkConstants.requestSettings
            case .rock:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFDXXwE9BDJAr/playlists" + NetworkConstants.requestSettings
            case .mood:
                return NetworkConstants.baseUrl + NetworkConstants.categories + "0JQ5DAqbMKFzHmL4tf05da/playlists" + NetworkConstants.requestSettings
        }
    }
    var name: String {
        switch self {
            case .topPlaylists:
                return "Хит-парады"
            case .relax:
                return "Релакс"
            case .pop:
                return "Поп"
            case .rock:
                return "Рок"
            case .mood:
                return "Настроение"
        }
    }
    
}

