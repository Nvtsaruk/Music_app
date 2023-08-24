struct Album: Codable {
    let total_tracks: Int
    let id: String
    let images: [ImageModel]?
    let name: String?
    let release_date: String
    let type: String? //Maybe enum
    let genres: [String]?
    let label: String?
    let artists: [AlbumArtist]?
    init(total_tracks: Int = 0, id: String = "", images: [ImageModel]? = nil, name: String? = nil, release_date: String = "", type: String? = nil, genres: [String]? = nil, label: String? = nil, artists: [AlbumArtist]? = nil) {
        self.total_tracks = total_tracks
        self.id = id
        self.images = images
        self.name = name
        self.release_date = release_date
        self.type = type
        self.genres = genres
        self.label = label
        self.artists = artists
    }
}

struct AlbumArtist: Codable {
    let followers: Followers?
    let genres: [String]?
    let id: String
    let images: [ImageModel]?
    let name: String?
    let type: String?
    init(followers: Followers? = nil, genres: [String]? = nil, id: String = "", images: [ImageModel]? = nil, name: String? = "", type: String? = nil) {
        self.followers = followers
        self.genres = genres
        self.id = id
        self.images = images
        self.name = name
        self.type = type
    }
}

struct AlbumTrack: Codable {
    let total: Int
    let items: [AlbumTrackItem]?
    init(total: Int = 0, items: [AlbumTrackItem]? = nil) {
        self.total = total
        self.items = items
    }
}

struct AlbumTrackItem: Codable {
    let artists: [AlbumTrackItemArtist]?
    let disc_number: Int
    let duration_ms: Int
    let id: String?
    let is_playable: Bool?
    let track_number: Int
    let name: String?
    let type: String?
    init(artists: [AlbumTrackItemArtist]? = nil, disc_number: Int = 0, duration_ms: Int = 0, id: String? = nil, is_playable: Bool? = nil, track_number: Int = 0, name: String? = nil, type: String? = nil) {
        self.artists = artists
        self.disc_number = disc_number
        self.duration_ms = duration_ms
        self.id = id
        self.is_playable = is_playable
        self.track_number = track_number
        self.name = name
        self.type = type
    }
}

struct AlbumTrackItemArtist: Codable {
    let id: String?
    let name: String?
    let type: String? //Maybe enum
    init(id: String? = nil, name: String? = nil, type: String? = nil) {
        self.id = id
        self.name = name
        self.type = type
    }
}

