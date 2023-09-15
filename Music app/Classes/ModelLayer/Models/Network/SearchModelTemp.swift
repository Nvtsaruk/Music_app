//struct SearchResults: Codable {
//    let albums: SearchAlbum
////    let artists: SearchArtists
////    let playlists: SearchPlaylists
////    let tracks: SearchTracks
//}
//
//struct SearchAlbum: Codable {
//    let href: String
////        let limit: Int
////        let next: String
////        let offset: Int
////        let total: Int
//        let items: [AlbumElement]
//}
//struct AlbumElement: Codable {
//    let albumType: AlbumTypeEnum
//    let totalTracks: Int
////    let availableMarkets: [String]
//    let externalUrls: ExternalUrls
//    let href: String
//    let id: String
//    let images: [ImageModel]
//    let name, releaseDate: String
////    let releaseDatePrecision: ReleaseDatePrecision
//    let type: AlbumTypeEnum
//    let uri: String
//    let artists: [Owner]
//
//    enum CodingKeys: String, CodingKey {
//        case albumType = "album_type"
//        case totalTracks = "total_tracks"
////        case availableMarkets = "available_markets"
//        case externalUrls = "external_urls"
//        case href, id, images, name
//        case releaseDate = "release_date"
////        case releaseDatePrecision = "release_date_precision"
//        case type, uri, artists
//    }
//}
//
//enum AlbumTypeEnum: String, Codable {
//    case album = "album"
//    case compilation = "compilation"
//    case single = "single"
//}
//
//struct Owner: Codable {
//    let externalUrls: ExternalUrls
//    let href: String
//    let id: String
//    let name: String?
//    let type: OwnerType
//    let uri: String
//    let displayName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case externalUrls = "external_urls"
//        case href, id, name, type, uri
//        case displayName = "display_name"
//    }
//}
//
////struct ExternalUrls: Codable {
////    let spotify: String
////}
//
//enum OwnerType: String, Codable {
//    case artist = "artist"
//    case user = "user"
//}
//
////enum ReleaseDatePrecision: String, Codable {
////    case day = "day"
////    case year = "year"
////}
//
////struct SearchArtists: Codable {
////    let href: String
////        let limit: Int
////        let next: String
////        let offset: Int
////        let total: Int
////        let items: [ArtistsItem]
////}
////
////struct ArtistsItem: Codable {
////    let externalUrls: ExternalUrls
////    let followers: Followers
////    let genres: [String]
////    let href: String
////    let id: String
////    let images: [ImageModel]
////    let name: String
////    let popularity: Int
////    let type: OwnerType
////    let uri: String
////
////    enum CodingKeys: String, CodingKey {
////        case externalUrls = "external_urls"
////        case followers, genres, href, id, images, name, popularity, type, uri
////    }
////}
////
////
////struct SearchPlaylists: Codable {
////    let href: String
////        let limit: Int
//////        let next: JSONNull?
////        let offset: Int
//////        let previous: JSONNull?
////        let total: Int
////        let items: [PlaylistsItem]
////}
////
////struct PlaylistsItem: Codable {
////    let collaborative: Bool
////    let description: String
////    let externalUrls: ExternalUrls
////    let href: String
////    let id: String
////    let images: [ImageModel]
////    let name: String
////    let owner: Owner
//////    let itemPublic: JSONNull?
////    let snapshotID: String
////    let tracks: Followers
//////    let type: PurpleType
////    let uri: String
////    let primaryColor: JSONNull?
//
////    enum CodingKeys: String, CodingKey {
////        case collaborative, description
////        case externalUrls = "external_urls"
////        case href, id, images, name, owner
////        case itemPublic = "public"
////        case snapshotID = "snapshot_id"
////        case tracks, type, uri
////        case primaryColor = "primary_color"
////    }
////}
//
////enum PurpleType: String, Codable {
////    case playlist = "playlist"
////}
//
////struct SearchTracks: Codable {
////    let href: String
////        let limit: Int
////        let next: String
////        let offset: Int
//////        let previous: JSONNull?
////        let total: Int
////        let items: [TracksItem]
////}
////
////struct TracksItem: Codable {
////    let album: AlbumElement
////    let artists: [Owner]
////    let availableMarkets: [String]
////    let discNumber, durationMS: Int
////    let explicit: Bool
////    let externalIDS: ExternalIDS
////    let externalUrls: ExternalUrls
////    let href: String
////    let id, name: String
////    let popularity: Int
////    let previewURL: String
////    let trackNumber: Int
////    let type: FluffyType
////    let uri: String
////    let isLocal: Bool
////
////    enum CodingKeys: String, CodingKey {
////        case album, artists
////        case availableMarkets = "available_markets"
////        case discNumber = "disc_number"
////        case durationMS = "duration_ms"
////        case explicit
////        case externalIDS = "external_ids"
////        case externalUrls = "external_urls"
////        case href, id, name, popularity
////        case previewURL = "preview_url"
////        case trackNumber = "track_number"
////        case type, uri
////        case isLocal = "is_local"
////    }
////}
////struct ExternalIDS: Codable {
////    let isrc: String
////}
////
////enum FluffyType: String, Codable {
////    case track = "track"
////}
