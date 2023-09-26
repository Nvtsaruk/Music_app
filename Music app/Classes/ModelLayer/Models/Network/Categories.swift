struct AllCategories: Decodable {
    let categories: Categories
}

struct Categories: Decodable {
    let items: [Category]
}

struct Category: Decodable {
    let id: String
    let name: String
    let icons: [ImageModel]
}
