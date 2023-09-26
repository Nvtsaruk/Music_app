import Foundation
struct ImageModel: Codable {
    var url: String
    init(url: String) {
        self.url = url
    }
    init() {
        self.url = ""
    }
}
