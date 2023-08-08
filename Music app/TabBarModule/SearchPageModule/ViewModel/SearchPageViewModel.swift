protocol SearchPageViewModelProtocol {
    func logout()
    func getPLaylists()
}

final class SearchPageViewModel: SearchPageViewModelProtocol {
    func logout() {
//        do {
//            let del = try KeychainManager.logout(for: <#T##String#>)
//            print("Data from keychain", del)
//
//        } catch {
//            print(error)
//        }
//        LoginManager.shared.refreshToken()
        LoginManager.shared.deleteAll()
        APIService.getUserProfile()
    }
    func getPLaylists() {
        APIService.getPlaylist()
    }

}
