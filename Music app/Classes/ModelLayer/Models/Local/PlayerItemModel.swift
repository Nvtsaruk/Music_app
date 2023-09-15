struct PlayerItemModel {
    var url: String
    var image: String
    var trackName: String
    var artistName: String
    init(url: String, image: String, trackName: String, artistName: String) {
        self.url = url
        self.image = image
        self.trackName = trackName
        self.artistName = artistName
    }
    init() {
        self.url = ""
        self.image = ""
        self.trackName = ""
        self.artistName = ""
    }
}
