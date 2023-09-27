struct Toplist: Decodable {
    let playlists: ToplistPlaylist
}

struct ToplistPlaylist: Decodable {
    let items: [ToplistPlaylistItem]
}

struct ToplistPlaylistItem: Decodable {
    let description: String
    let id: String
    let images: [ImageModel]
    let name: String
    let type: String
}

