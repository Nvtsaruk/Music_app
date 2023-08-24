import Foundation

enum PlaylistsNames: CaseIterable {
    case topPlaylists
//    case featuredPlaylists
    case relax
    case pop
    case rock
    case training
    
    var name: String {
        switch self {
            case .topPlaylists:
                return "Хит-парады"
            case .relax:
                return "Релакс"
//            case .featuredPlaylists:
//                return "Выбери тот самый плейлист"
            case .pop:
                return "Поп"
            case .rock:
                return "Рок"
            case .training:
                return "Тренировка"
        }
    }
}
struct PlaylistModel: Codable {
    let collaborative: Bool?
    let description: String?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let owner: PlaylistModelOwner?
    let snapshot_id: String?
    var tracks: PlaylistModelTracks?
    let type: String? //enum
    init(collaborative: Bool? = nil, description: String? = nil, followers: Followers? = nil, href: String? = nil, id: String? = nil, images: [ImageModel]? = nil, name: String? = nil, owner: PlaylistModelOwner? = nil, snapshot_id: String? = nil, tracks: PlaylistModelTracks? = nil, type: String? = nil) {
        self.collaborative = collaborative
        self.description = description
        self.followers = followers
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.owner = owner
        self.snapshot_id = snapshot_id
        self.tracks = tracks
        self.type = type
    }
}

struct PlaylistModelOwner: Codable {
    let display_name: String?
    let href: String?
    let id: String?
    let type: String? //Maybe enum
    init(display_name: String? = nil, href: String? = nil, id: String? = nil, type: String? = nil) {
        self.display_name = display_name
        self.href = href
        self.id = id
        self.type = type
    }
}

struct PlaylistModelTracks: Codable {
    let href: String?
    let total: Int?
    var items: [PlaylistModelTracksItem]?
    init(href: String? = nil, total: Int? = nil, items: [PlaylistModelTracksItem]? = nil) {
        self.href = href
        self.total = total
        self.items = items
    }
}

struct PlaylistModelTracksItem: Codable {
    let added_at: String? //Date
    let added_by: PlaylistModelTracksItemUser?
    let track: Track?
    init(added_at: String? = nil, added_by: PlaylistModelTracksItemUser? = nil, track: Track? = nil) {
        self.added_at = added_at
        self.added_by = added_by
        self.track = track
    }
}

struct PlaylistModelTracksItemUser: Codable {
    let href: String?
    let id: String?
    let type: String? //enum
    init(href: String? = nil, id: String? = nil, type: String? = nil) {
        self.href = href
        self.id = id
        self.type = type
    }
}

struct Track: Codable {
    let album: TrackAlbum?
    let artists: [TrackAlbumArtist]?
    let duration_ms: Int?
    let href: String?
    let id: String?
    let name: String?
    let preview_url: URL?
    let track: Bool?
    let track_number: Int?
    let type: String? //ENUM
    init(album: TrackAlbum? = nil, artists: [TrackAlbumArtist]? = nil, duration_ms: Int? = nil, href: String? = nil, id: String? = nil, name: String? = nil, preview_url: URL? = nil, track: Bool? = nil, track_number: Int? = nil, type: String? = nil) {
        self.album = album
        self.artists = artists
        self.duration_ms = duration_ms
        self.href = href
        self.id = id
        self.name = name
        self.preview_url = preview_url
        self.track = track
        self.track_number = track_number
        self.type = type
    }
}

struct TrackAlbum: Codable {
    let album_type: String?
    let artists: [TrackAlbumArtist]?
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let release_date: String?
    let total_tracks: Int?
    let type: String? //enum
    init(album_type: String? = nil, artists: [TrackAlbumArtist]? = nil, href: String? = nil, id: String? = nil, images: [ImageModel]? = nil, name: String? = nil, release_date: String? = nil, total_tracks: Int? = nil, type: String? = nil) {
        self.album_type = album_type
        self.artists = artists
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.release_date = release_date
        self.total_tracks = total_tracks
        self.type = type
    }
}

struct TrackAlbumArtist: Codable {
    let href: String?
    let id: String?
    let name: String?
    let type: String? //enum
    init(href: String? = nil, id: String? = nil, name: String? = nil, type: String? = nil) {
        self.href = href
        self.id = id
        self.name = name
        self.type = type
    }
}

