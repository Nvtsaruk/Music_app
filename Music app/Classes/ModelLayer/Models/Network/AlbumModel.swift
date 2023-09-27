struct Album: Decodable {
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    var tracks: AlbumTrack
    let type: String
}

struct AlbumTrack: Decodable {
    var items: [Track]
}

