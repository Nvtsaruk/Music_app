struct FeaturedPlaylists: Codable {
    let message: String?
    let playlists: Playlists
}

struct Playlists: Codable {
    let total: Int
    let items: [PlaylistsItem]
}

struct PlaylistsItem: Codable {
    let collaborative: Bool?
    let description: String?
    let id: String?
    let images: [ImageModel]?
    let name: String?
    let owner: PlaylistsItemOwner
}

struct PlaylistsItemOwner: Codable {
    let followers: Followers?
    let id: String?
    let type: String? //Maybe enum
    let display_name: String?
}

//    "items": [
//      {
//        "public": false,
//        "snapshot_id": "string",
//        "tracks": {
//          "href": "string",
//          "total": 0
//        },
//        "type": "string",
//        "uri": "string"
//      }
//    ]
//  }
//}
