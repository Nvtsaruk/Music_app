struct AllCategories: Decodable {
    let categories: Categories
    init(categories: Categories) {
        self.categories = categories
    }
    init() {
        self.categories = Categories(items: [])
    }
}

struct Categories: Decodable {
    let items: [Category]
    init(items: [Category]) {
        self.items = items
    }
    init() {
        self.items = []
    }
}

struct Category: Decodable {
    let id: String
    let name: String
    let icons: [ImageModel]
    
    init(id: String, name: String, icons: [ImageModel]) {
        self.id = id
        self.name = name
        self.icons = icons
    }
    init() {
        self.id = ""
        self.name = ""
        self.icons = []
    }
}