import Foundation
protocol UserProfileViewModelProtocol {
    var title: String { get }
    func logout()
    func getUserInfo()
    func showDetails()
    var updateClosure:( ()->Void )? { get set }
    var currentUser: UserProfile { get }
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    var currentUser: UserProfile = UserProfile() {
        didSet {
            updateClosure?()
        }
    }
    var title = "Settings"
    
    func getUserInfo() {
        let url = NetworkConstants.userProfileUrl
        APIService.getData(UserProfile.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.currentUser = data
                case .failure(let error):
                    print("Custom Error -> \(error)")
            }
        }
    }
    
    func showDetails() {
        coordinator?.showUserDetails(currentUser: currentUser)
    }
    
    func logout() {
        LoginManager.shared.deleteAll()
        coordinator?.showLogin()
    }
}
