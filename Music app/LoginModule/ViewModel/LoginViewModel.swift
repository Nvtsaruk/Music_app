import Foundation


final class LoginViewModel: LoginViewModelProtocol {
    
    weak var coordinator: LoginCoordinator?
    var updateClosure: (() -> Void)?
    
    var signInURL: URL? {
        let scopes = "user-read-private"
        let string = "\(NetworkConstants.baseAPICodeUrl)?response_type=code&client_id=\(AppConstants.clientID)&scope=\(scopes)&redirect_uri=\(NetworkConstants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    var loginCode: String = "" {
        didSet {
            print("Code: \(loginCode)")
            updateClosure?()
            LoginManager().getToken(loginCode: loginCode)
        }
    }
    
    
}
