import Foundation
struct SearchResults: Codable {
    let albums: SearchAlbum
    let artists: SearchArtists
    let playlists: SearchPlaylists
    let tracks: SearchTracks
    
    init(albums: SearchAlbum, artists: SearchArtists, playlists: SearchPlaylists, tracks: SearchTracks) {
        self.albums = albums
        self.artists = artists
        self.playlists = playlists
        self.tracks = tracks
    }
    init() {
        self.albums = SearchAlbum()
        self.artists = SearchArtists()
        self.playlists = SearchPlaylists()
        self.tracks = SearchTracks()
    }
}

struct SearchAlbum: Codable {
    let items: [SearchAlbumItem]
    let total: Int
    
    init(items: [SearchAlbumItem], total: Int) {
        self.items = items
        self.total = total
    }
    init() {
        self.items = []
        self.total = 0
    }
}

struct SearchArtists: Codable {
    let items: [SearchArtistsItem]
    let total: Int
    init(items: [SearchArtistsItem], total: Int) {
        self.items = items
        self.total = total
    }
    init() {
        self.items = []
        self.total = 0
    }
}
struct SearchPlaylists: Codable {
    let items: [PlaylistModel]
//    let total: Int?
    init(items: [PlaylistModel]) {
        self.items = items
    }
    init() {
        self.items = []
    }
}

struct SearchTracks: Codable {
    let items: [SearchTracksItem]
    
    init(items: [SearchTracksItem]) {
        self.items = items
    }
    init() {
        self.items = []
    }
}

struct SearchAlbumItem: Codable {
//    let album_type: String? //Enum
    let artists: [SearchAlbumItemArtists]
//    let href: String?
    let id: String
    let images: [ImageModel]?
    let name: String
    let release_date: String?
//    let total_tracks: Int?
    let type: String //Enum
}

struct SearchArtistsItem: Codable {
//    let followers: Followers?
//    let genres: [String]?
//    let href: String?
    let id: String
    let images: [ImageModel]?
    let name: String
//    let popularity: Int?
    let type: String
}



struct SearchAlbumItemArtists: Codable {
    let href: String
    let id: String
    let name: String
    let type: String
}



struct SearchTracksItem: Codable {
    let album: SearchTracksItemAlbum
    let artists: [SearchTracksItemArtists]
//    let disc_number: Int?
//    let duration_ms: Int?
//    let href: String?
    let id: String
    let name: String
//    let popularity: Int?
    let preview_url: String?
//    let track_number: Int?
    let type: String
}

struct SearchTracksItemAlbum: Codable {
//    let album_type: String?
    let artists: [SearchTracksItemArtists]
//    let href: String?
    let id: String
    let images: [ImageModel]?
    let name: String
    let release_date: String?
//    let total_tracks: Int?
    let type: String
}

struct SearchTracksItemArtists: Codable {
//    let href: String?
    let id: String
    let name: String
    let type: String
}



