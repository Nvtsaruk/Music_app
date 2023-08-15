import Foundation
protocol UserProfileViewModelProtocol {
    var title: String { get }
    func logout()
    func getUserInfo()
    func showDetails()
    var updateClosure:( ()->Void )? { get set }
    var currentUser: CurrentUser { get }
}

struct CurrentUser {
    var name: String
    var avatar: String?
    var email: String
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    var currentUser: CurrentUser = CurrentUser(name: "", email: "") {
        didSet {
            updateClosure?()
        }
    }
    var title = "Settings"
    
    func getUserInfo() {
        let url = "https://api.spotify.com/v1/me"
        APIService.getData(UserProfile.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.currentUser.name = data.displayName
                    self.currentUser.email = data.email
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func showDetails() {
        coordinator?.showUserDetails()
    }
    
    
    func logout() {
        LoginManager.shared.deleteAll()
        
    }
}
