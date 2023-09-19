struct Artist: Codable {
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
