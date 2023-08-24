import Foundation
protocol UserProfileViewModelProtocol {
    var title: String { get }
    func logout()
    func getUserInfo()
    func showDetails()
    var updateClosure:( ()->Void )? { get set }
    var currentUser: UserProfile { get }
}

//struct CurrentUser {
//    var name: String
//    var avatar: URL?
//    var email: String
//    var subscribers: Int
//    init(name: String = "", avatar: URL? = nil, email: String = "", subscribers: Int = 0) {
//        self.name = name
//        self.avatar = avatar
//        self.email = email
//        self.subscribers = subscribers
//    }
//}

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
