import Foundation
protocol SearchPageViewModelProtocol {
    func search(item: String)
//    var searchModel: SearchResults { get }
    var updateClosure:( ()->Void )? { get set }
    func backToSearchCategories()
}

final class SearchPageViewModel: SearchPageViewModelProtocol {
    
    
    var coordinator: SearchPageCoordinator?
    var lastScheduledSearch: Timer?
    
    var updateClosure: (() -> Void)?
    
    var searchModel: SearchResults = SearchResults() {
        didSet {
            updateClosure?()
        }
    }
    
    func search(item: String) {
        lastScheduledSearch?.invalidate()
        lastScheduledSearch = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchQuery(_:)), userInfo: item, repeats: false)
        
    }
    
    @objc private func searchQuery(_ timer: Timer) {
        guard let text = timer.userInfo else { return }
        let url = NetworkConstants.baseUrl + NetworkConstants.search + ((text as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        APIService.getData(SearchResults.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.searchModel = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func showPlaylistDetail(id: String) {
        coordinator?.showPlaylistDetail(id: id)
    }
    
    func showArtistDetail(id: String) {
        coordinator?.showArtistDetail(id: id)
    }
    
    func showAlbumDetail(id: String) {
        coordinator?.showAlbumDetail(id: id)
    }
    
    func backToSearchCategories() {
        coordinator?.popToRoot()
    }

}
