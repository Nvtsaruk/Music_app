struct PlaylistModel: Decodable {
    var description: String
    let id: String
    var images: [ImageModel]
    var name: String
    let owner: PlaylistModelOwner
    var tracks: PlaylistModelTracks
    let type: String
}

struct PlaylistModelOwner: Decodable {
    let display_name: String
    let id: String
    let type: String
}

struct PlaylistModelTracks: Decodable {
    var items: [PlaylistModelTracksItem]
}

struct PlaylistModelTracksItem: Decodable {
    let added_at: String
    let added_by: PlaylistModelTracksItemUser
    var track: Track
}

struct PlaylistModelTracksItemUser: Decodable {
    let id: String
    let type: String
}



struct TrackAlbum: Decodable {
    let album_type: String
    let artists: [TrackAlbumArtist]
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    let type: String
}

struct TrackAlbumArtist: Codable {
    let id: String
    let name: String
    let type: String
}

