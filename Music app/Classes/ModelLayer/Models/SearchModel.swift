import Foundation
struct SearchResults: Codable {
    let albums: SearchAlbum
    let artists: SearchArtists
    let playlists: SearchPlaylists
    let tracks: SearchTracks
}

struct SearchAlbum: Codable {
    let items: [SearchAlbumItem]
    let total: Int
}

struct SearchAlbumItem: Codable {
    let album_type: String? //Enum
    let artists: [SearchAlbumItemArtists]
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let release_date: String?
    let total_tracks: Int?
    let type: String? //Enum
}

struct SearchAlbumItemArtists: Codable {
    let href: String?
    let id: String?
    let name: String?
    let type: String?
}

struct SearchArtists: Codable {
    let items: [SearchArtistsItem]
    let total: Int
}

struct SearchArtistsItem: Codable {
    let followers: Followers?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let popularity: Int?
    let type: String?
}

struct SearchTracks: Codable {
    let items: [SearchTracksItem]
    let total: Int
}

struct SearchTracksItem: Codable {
    let album: SearchTracksItemAlbum
    let artists: [SearchTracksItemArtists]
    let disc_number: Int?
    let duration_ms: Int?
    let href: String?
    let id: String?
    let name: String?
    let popularity: Int?
    let preview_url: URL?
    let track_number: Int?
    let type: String?
}

struct SearchTracksItemAlbum: Codable {
    let album_type: String?
    let artists: [SearchTracksItemArtists]
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let release_date: String?
    let total_tracks: Int?
    let type: String?
}

struct SearchTracksItemArtists: Codable {
    let href: String?
    let id: String?
    let name: String?
    let type: String?
}

struct SearchPlaylists: Codable {
    let items: [PlaylistModel]?
    let total: Int?
}

