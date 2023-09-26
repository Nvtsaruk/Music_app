struct NewReleases: Codable {
    let albums: NewReleasesAlbums
}

struct NewReleasesAlbums: Codable {
    let total: Int
    let items: [NewReleasesItem]
}

struct NewReleasesItem: Codable {
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    let artists: [NewReleasesArtist]
}

struct NewReleasesArtist: Codable {
    let id: String?
    let name: String?
    let type: String?
}

