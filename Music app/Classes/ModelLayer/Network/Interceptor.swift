import Foundation
import Alamofire

class APIRequestInterceptor: RequestInterceptor {
    private var token: Token = Token(accessToken: "")
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        do {
            let data = try CredentialStorageService().getPassword(for: KeychainConstants.accessToken.key)
            self.token.accessToken = String(decoding: data ?? Data(), as: UTF8.self)
        } catch {
            CustomErrors.brokenAccessToken.createAllert()
        }
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: token.accessToken))
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, let responseError = error.asAFError, response.statusCode == 401 || response.statusCode == 400 || responseError.isResponseSerializationError {
            LoginManager.shared.refreshToken()
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}
