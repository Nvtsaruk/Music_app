import Foundation
protocol SearchCategoriesViewModelProtocol {
    var updateClosure:( ()->Void )? { get set }
    var categories: AllCategories? { get }
    var isLoading: Bool { get }
    func showSearchPage()
    func getCategories()
    func showDetails(id: String, name: String)
}

final class SearchCategoriesViewModel: SearchCategoriesViewModelProtocol {
    
    var categories: AllCategories? {
        didSet {
            updateClosure?()
        }
    }
    
    var coordinator: SearchPageCoordinator?
    
    var updateClosure: (() -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    func showSearchPage() {
        coordinator?.showSearchTabbar()
    }
    
    func getCategories() {
            APIService.getData(AllCategories.self, url: NetworkConstants.baseUrl + NetworkConstants.categories + NetworkConstants.requestSettings) { result in
                switch result {
                    case .success(let data):
                        self.categories = data
                    case .failure(let error):
                        ErrorHandler.shared.handleError(error: error)
                }
            }
    }
    func showDetails(id: String, name: String) {
        coordinator?.showDetails(id: id, name: name)
    }

}
