import Foundation


final class LoginViewModel: LoginViewModelProtocol {
    
    weak var coordinator: LoginCoordinator?
    var updateClosure: (() -> Void)?
    
    var signInURL: URL? {
        let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
        let string = "\(NetworkConstants.baseAPICodeUrl)?response_type=code&client_id=\(AppConstants.clientID)&scope=\(scopes)&redirect_uri=\(NetworkConstants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    var loginCode: String = "" {
        didSet {
            updateClosure?()
            LoginManager().getToken(loginCode: loginCode)
        }
    }
    func goToTabBar() {
        coordinator?.showTabBar()
    }
    
    
}
