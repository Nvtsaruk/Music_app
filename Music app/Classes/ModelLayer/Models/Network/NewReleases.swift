struct NewReleases: Codable {
    let albums: NewReleasesAlbums
}

struct NewReleasesAlbums: Codable {
    let total: Int
    let items: [NewReleasesItem]
}

struct NewReleasesItem: Codable {
    let album_type: String //Maybe enum
    let total_tracks: Int
//    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let release_date: String?
//    let type: String?
    let genres: [String]?
    let label: String?
    let artists: [NewReleasesArtist]
}

struct NewReleasesArtist: Codable {
//    let href: String?
    let id: String?
    let name: String?
    let type: String?
}

