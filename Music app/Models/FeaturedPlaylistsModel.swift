import Foundation
// MARK: - Featured Playlists
struct FeaturedPlaylists: Codable {
    let message: String?
}
//    let playlists: Playlists
//}
//
////// MARK: - Playlists
//struct Playlists: Codable {
//    let href: String
//    let limit: Int?
//    let next: String?
//    let offset: Int
//    let previous: String?
//    let total: Int
//    let items: [Item]
//}
////
////// MARK: - Item
//struct Item: Codable {
//    let collaborative: Bool
//    let description: String
//    let externalUrls: ExternalUrlsStructs
//    let href, id: String
//    let images: [PlaylistImage]
//    let name: String
//    let owner: Owner?
//    let itemPublic: Bool
//    let snapshotID: String
//    let tracks: Tracks
//    let type, uri: String
//
//    enum CodingKeys: String, CodingKey {
//        case collaborative, description
//        case externalUrls = "external_urls"
//        case href, id, images, name, owner
//        case itemPublic = "public"
//        case snapshotID = "snapshot_id"
//        case tracks, type, uri
//    }
//}
////
////// MARK: - ExternalUrls
//struct ExternalUrlsStructs: Codable {
//    let spotify: String
//}
////
////// MARK: - Image
//struct PlaylistImage: Codable {
//    let url: String?
//    let height, width: Int?
//}
////
////// MARK: - Owner
//struct Owner: Codable {
//    let externalUrls: ExternalUrlsStructs
//    let followers: Tracks?
//    let href, id, type, uri: String
//    let displayName: String
//
//    enum CodingKeys: String, CodingKey {
//        case externalUrls = "external_urls"
//        case followers, href, id, type, uri
//        case displayName = "display_name"
//    }
//}
////
////// MARK: - Tracks
//struct Tracks: Codable {
//    let href: String
//    let total: Int
//}
