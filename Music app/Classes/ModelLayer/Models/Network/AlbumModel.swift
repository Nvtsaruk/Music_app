struct Album: Decodable {
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    var tracks: AlbumTrack
    let type: String
}

struct AlbumTrack: Decodable {
    var items: [SimplifiedTrack]
}

struct SimplifiedTrack: Decodable {
    let artists: [SimplifiedArtist]
    let id: String
    let name: String
    let preview_url: String?
    let type: String
}

struct SimplifiedArtist: Decodable {
    let name: String
}
