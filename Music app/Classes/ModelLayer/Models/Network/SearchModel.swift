struct SearchResults: Decodable {
    let albums: SearchAlbum
    let artists: SearchArtists
    let playlists: SearchPlaylists
    var tracks: SearchTracks
}

struct SearchAlbum: Decodable {
    let items: [SearchAlbumItem]
    let total: Int
}

struct SearchArtists: Decodable {
    let items: [SearchArtistsItem]
    let total: Int
}
struct SearchPlaylists: Decodable {
    let items: [PlaylistModel]
}

struct SearchTracks: Decodable {
    var items: [SearchTracksItem]
}

struct SearchAlbumItem: Decodable {
    let artists: [SearchAlbumItemArtists]
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    let type: String
}

struct SearchArtistsItem: Decodable {
    let id: String
    let images: [ImageModel]
    let name: String
    let type: String
}



struct SearchAlbumItemArtists: Decodable {
    let href: String
    let id: String
    let name: String
    let type: String
}



struct SearchTracksItem: Decodable {
    let album: SearchTracksItemAlbum
    let artists: [SearchTracksItemArtists]
    let id: String
    let name: String
    let preview_url: String?
    let type: String
}

struct SearchTracksItemAlbum: Decodable {
    let artists: [SearchTracksItemArtists]
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String?
    let type: String
}

struct SearchTracksItemArtists: Decodable {
    let id: String
    let name: String
    let type: String
}



