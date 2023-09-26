struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let id: String
    let product: String
    let images: [ImageModel]
    init(country: String, display_name: String, email: String, id: String, product: String, images: [ImageModel]) {
        self.country = country
        self.display_name = display_name
        self.email = email
        self.id = id
        self.product = product
        self.images = images
    }
    init() {
        self.country = ""
        self.display_name = ""
        self.email = ""
        self.id = ""
        self.product = ""
        self.images = []
    }
}
