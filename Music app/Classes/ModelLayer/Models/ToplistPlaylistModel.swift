struct Toplist: Codable {
    let playlists: ToplistPlaylist?
    init(playlists: ToplistPlaylist? = nil) {
        self.playlists = playlists
    }
}

struct ToplistPlaylist: Codable {
    let href: String?
    let items: [ToplistPlaylistItem]?
    init(href: String? = nil, items: [ToplistPlaylistItem]? = nil) {
        self.href = href
        self.items = items
    }
}

struct ToplistPlaylistItem: Codable {
    let collaborative: Bool?
    let description: String?
    let id: String
    let images: [ImageModel]?
    let name: String?
    let snapshot_id: String?
    let tracks: PlaylistsItemTracks?
    let type: String?
    init(collaborative: Bool? = true, description: String? = nil, id: String = "", images: [ImageModel]? = nil, name: String? = nil, snapshot_id: String? = nil, tracks: PlaylistsItemTracks? = nil, type: String? = nil) {
        self.collaborative = collaborative
        self.description = description
        self.id = id
        self.images = images
        self.name = name
        self.snapshot_id = snapshot_id
        self.tracks = tracks
        self.type = type
    }
}

struct PlaylistsItemTracks: Codable {
    let href: String?
    let total: Int
    init(href: String? = nil, total: Int = 0) {
        self.href = href
        self.total = total
    }
}
