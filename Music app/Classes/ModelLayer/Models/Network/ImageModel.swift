import Foundation
struct ImageModel: Codable {
    let url: String
    init(url: String) {
        self.url = url
    }
    init() {
        self.url = ""
    }
}
