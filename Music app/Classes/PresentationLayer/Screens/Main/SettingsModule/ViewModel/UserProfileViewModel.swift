import Foundation
protocol UserProfileViewModelProtocol {
    func logout()
    func getUserInfo()
    func showDetails()
    var updateClosure:( ()->Void )? { get set }
    var currentUser: UserProfile? { get }
    var isLoading: Bool { get set }
}

final class UserProfileViewModel: UserProfileViewModelProtocol {
    
    //MARK: - Variables
    var updateClosure: (() -> Void)?
    var coordinator: MainPageCoordinator?
    var currentUser: UserProfile? {
        didSet {
            updateClosure?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            updateClosure?()
        }
    }
    
    func getUserInfo() {
        isLoading = true
        let url = NetworkConstants.userProfileUrl
        APIService.getData(UserProfile.self, url: url) { result in
            switch result {
                case .success(let data):
                    self.isLoading = false
                    self.currentUser = data
                case .failure(let error):
                    ErrorHandler.shared.handleError(error: error)
            }
        }
    }
    
    func showDetails() {
        guard let currentUser = currentUser else { return }
        coordinator?.showUserDetails(currentUser: currentUser)
    }
    
    func logout() {
        LoginManager.shared.deleteAll()
        coordinator?.showLogin()
    }
}
