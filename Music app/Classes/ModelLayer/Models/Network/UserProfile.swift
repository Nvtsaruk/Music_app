struct UserProfile: Decodable {
    let country: String
    let display_name: String
    let email: String
    let id: String
    let product: String
    let images: [ImageModel]
}
