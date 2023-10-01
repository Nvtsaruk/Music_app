import Alamofire
import Foundation

struct TokenRequest:Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
}

final class LoginManager {
    static let shared = LoginManager()
    
    private init() {}
    
    func getToken(loginCode: String) {
        
        let basicToken = AppConstants.clientID + ":" + AppConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else { return }
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization" : "Basic \(base64String)"
        ]
        
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "code" : loginCode,
            "redirect_uri": NetworkConstants.redirectURI
        ]
        
        AF.request(NetworkConstants.tokenAPIUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable(of: TokenRequest.self) { response in
            switch response.result {
                case .success(let value):
                    guard let accessToken = value.access_token.data(using: .utf8) else { return }
                    guard let refreshToken = value.refresh_token?.data(using: .utf8) else { return }
                    CredentialStorageService().saveAccessToken(token: accessToken)
                    CredentialStorageService().saveRefreshToken(token: refreshToken)
                case .failure(let error):
                    switch error {
                        case .createURLRequestFailed(error: _):
                            CustomErrors.linkError.createAllert()
                        case .invalidURL(url: _):
                            CustomErrors.linkError.createAllert()
                        case .requestAdaptationFailed(error: _):
                            CustomErrors.dataError.createAllert()
                        case .responseSerializationFailed(reason: _):
                            CustomErrors.jsonDecodeError.createAllert()
                        default:
                            CustomErrors.otherError.createAllert()
                    }
            }
        }
    }
    func refreshToken() {
        let basicToken = AppConstants.clientID + ":" + AppConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else { return }
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization" : "Basic \(base64String)"
        ]
        var refreshToken = ""
        do {
            let keychainRefresh = try CredentialStorageService().getPassword(for: KeychainConstants.refreshToken.key)
            refreshToken = String(decoding: keychainRefresh ?? Data(), as: UTF8.self)
        } catch {
            CustomErrors.authError.createAllert()
        }
        
        let parameters: [String: String] = [
            "grant_type": KeychainConstants.refreshToken.key,
            KeychainConstants.refreshToken.key : refreshToken
        ]
        
        AF.request(NetworkConstants.tokenAPIUrl, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable(of: TokenRequest.self) { response in
            switch response.result {
                case .success(let value):
                    guard let accessToken = value.access_token.data(using: .utf8) else { return }
                    CredentialStorageService().saveAccessToken(token: accessToken)
                case .failure(_):
                    CustomErrors.authError.createAllert()
            }
        }
    }
    func deleteAll() {
        [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity].forEach {
            let status = SecItemDelete([
                kSecClass: $0,
                kSecAttrSynchronizable: kSecAttrSynchronizableAny
            ] as CFDictionary)
            if status != errSecSuccess && status != errSecItemNotFound {
            }
        }
    }
}
