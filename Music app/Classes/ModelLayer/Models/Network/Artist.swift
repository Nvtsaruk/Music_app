struct Artist: Decodable {
    let id: String
    let images: [ImageModel]
    let name: String
    let type: String
}
