struct Track: Decodable {
    let album: TrackAlbum
    let artists: [TrackAlbumArtist]
    let id: String
    let name: String
    let preview_url: String?
    let type: String
}

