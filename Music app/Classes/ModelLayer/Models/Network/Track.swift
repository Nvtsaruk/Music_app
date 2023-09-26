struct Track: Codable {
    let album: TrackAlbum?
    let artists: [TrackAlbumArtist]?
    let id: String
    let name: String
    let preview_url: String?
    let type: String
    init(album: TrackAlbum? = nil, artists: [TrackAlbumArtist]? = nil, id: String, name: String, preview_url: String? = nil, type: String) {
        self.album = album
        self.artists = artists
        self.id = id
        self.name = name
        self.preview_url = preview_url
        self.type = type
    }
    init () {
        self.album = TrackAlbum()
        self.artists = []
        self.id = ""
        self.name = ""
        self.preview_url = ""
        self.type = ""
    }
}

