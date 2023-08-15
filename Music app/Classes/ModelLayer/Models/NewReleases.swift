struct NewReleases: Codable {
    let albums: Albums
}
struct Albums: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
//    let available_markets: [String]
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
}

