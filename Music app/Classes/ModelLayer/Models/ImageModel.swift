import Foundation
struct ImageModel: Codable {
    let url: URL?
    let height: Int?
    let width: Int?
    init(url: URL? = nil, height: Int? = nil, width: Int? = nil) {
        self.url = url
        self.height = height
        self.width = width
    }
}
