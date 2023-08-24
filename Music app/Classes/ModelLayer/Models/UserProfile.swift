struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
//    let explicit_content: ExplicitContent?
//    let external_urls: ExternalUrls?
    let followers: Followers?
//    let href: String
    let id: String
    let images: [ImageModel]?
    let product: String
    let type: String
    let uri: String
    init(country: String = "", display_name: String = "", email: String = "", followers: Followers? = nil, id: String = "", images: [ImageModel]? = nil, product: String = "", type: String = "", uri: String = "") {
        self.country = country
        self.display_name = display_name
        self.email = email
        self.followers = followers
        self.id = id
        self.images = images
        self.product = product
        self.type = type
        self.uri = uri
    }
}

struct ExplicitContent: Codable {
    let filter_enabled: Bool?
    let filter_locked: Bool?
    init(filter_enabled: Bool? = nil, filter_locked: Bool? = nil) {
        self.filter_enabled = filter_enabled
        self.filter_locked = filter_locked
    }
}

struct ExternalUrls: Codable {
    let spotify: String?
    init(spotify: String? = nil) {
        self.spotify = spotify
    }
}










//struct UserProfile: Codable {
//    let country: String
//    let displayName: String
//    let email: String
//    let explicitContent: ExplicitContent
//    let externalUrls: ExternalUrls
//    let followers: Followers?
//    let href, id: String
//    let images: [ImageModel]
//    let product, type, uri: String
//
//    enum CodingKeys: String, CodingKey {
//        case country
//        case displayName = "display_name"
//        case email
//        case explicitContent = "explicit_content"
//        case externalUrls = "external_urls"
//        case followers, href, id, images, product, type, uri
//    }
//}
//
//// MARK: - ExplicitContent
//struct ExplicitContent: Codable {
//    let filterEnabled, filterLocked: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case filterEnabled = "filter_enabled"
//        case filterLocked = "filter_locked"
//    }
//}
//
//// MARK: - ExternalUrls
//struct ExternalUrls: Codable {
//    let spotify: String
//}
//
//// MARK: - Followers
//struct Followers: Codable {
//    let href: String?
//    let total: Int
//}
