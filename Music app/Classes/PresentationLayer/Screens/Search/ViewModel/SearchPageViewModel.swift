import Foundation
protocol SearchPageViewModelProtocol {
    func search(item: String)
//    var searchModel: SearchResults { get }
    var updateClosure:( ()->Void )? { get set }
}

final class SearchPageViewModel: SearchPageViewModelProtocol {
    var lastScheduledSearch: Timer?
    
    var updateClosure: (() -> Void)?
    
//    var searchModel: SearchResults = SearchResults(albums: SearchAlbum(href: "", items: [AlbumElement(albumType: AlbumTypeEnum.album, totalTracks: 0, externalUrls: ExternalUrls(spotify: ""), href: "", id: "", images: [ImageModel(url: "")], name: "", releaseDate: "", type: AlbumTypeEnum.album, uri: "", artists: [Owner(externalUrls: ExternalUrls(spotify: ""), href: "", id: "", name: "", type: OwnerType.artist, uri: "", displayName: "")])])) {
//        didSet {
//            updateClosure?()
//        }
//    }
    
    func search(item: String) {
        
        lastScheduledSearch?.invalidate()
        lastScheduledSearch = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchQuery(_:)), userInfo: item, repeats: false)
        print("Searching for \(item) scheduled")
    }
    
    @objc private func searchQuery(_ timer: Timer) {
        guard let text = timer.userInfo else { return }
        let url = "https://api.spotify.com/v1/search?limit=10&type=album,artist,playlist,track&q=\((text as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
//        APIService.getData(SearchResults.self, url: url) { result in
//            switch result {
//                case .success(let data):
//                    self.searchModel = data
//                case .failure(let error):
//                    print("Custom Error -> \(error)")
//            }
//        }
    }

}
