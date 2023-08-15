protocol SearchPageViewModelProtocol {
    func search(item: String)
}

final class SearchPageViewModel: SearchPageViewModelProtocol {
    func search(item: String) {
        print(item)
    }

}
