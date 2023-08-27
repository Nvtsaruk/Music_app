import Foundation
struct ImageModel: Codable {
    let url: URL
    init(url: URL) {
        self.url = url
    }
    init() {
        self.url = URL(string: "")!
    }
}
