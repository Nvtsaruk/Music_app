import Foundation
protocol SearchCategoriesViewModelProtocol {
    func showSearchPage()
    var updateClosure:( ()->Void )? { get set }
    func getCategories()
    var categories: AllCategories? { get }
    func showDetails(id: String, name: String)
}

final class SearchCategoriesViewModel: SearchCategoriesViewModelProtocol {
    
    var categories: AllCategories? = AllCategories() {
        didSet {
            updateClosure?()
        }
    }
    var coordinator: SearchPageCoordinator?
    
    var updateClosure: (() -> Void)?
    
    
    func showSearchPage() {
        coordinator?.showSearchTabbar()
    }
    
    func getCategories() {
            APIService.getData(AllCategories.self, url: NetworkConstants.baseUrl + NetworkConstants.categories + NetworkConstants.requestSettings) { result in
                switch result {
                    case .success(let data):
                        self.categories = data
//                        print(data.categories.items)
//                        self.updateClosure?()
                    case .failure(let error):
                        print("Custom Error -> \(error)")
                }
            }
    }
    func showDetails(id: String, name: String) {
        coordinator?.showDetails(id: id, name: name)
    }

}
