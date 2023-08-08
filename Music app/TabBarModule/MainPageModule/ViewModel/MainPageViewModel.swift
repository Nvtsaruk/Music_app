import Foundation

protocol MainPageViewModelProtocol {
    func showUserProfile()
    func logout()
    func getPLaylists()
}

final class MainPageViewModel: MainPageViewModelProtocol {
    
    weak var coordinator: MainPageCoordinator?
    
    func showUserProfile() {
        print("Button")
        print(coordinator)
        coordinator?.goToUserProfile()
    }
    
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
//        APIService.getUserProfile()
    }
    func getPLaylists() {
        APIService.getPlaylist()
    }

}
