import Security
import Foundation
import KeychainSwift

enum KeychainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}

enum KeychainConstants {
    case accessToken
    case refreshToken
    var key: String {
        switch self {
            case .accessToken:
                return "access_token"
            case .refreshToken:
                return "refresh_token"
        }
    }
}

final class CredentialStorageService {
    
    let keychain = KeychainSwift()
    func isUserLoggedIn() -> Bool {
        if keychain.getData(KeychainConstants.accessToken.key) != nil {
            return true
        } else {
            return false
        }
    }
    func saveAccessToken(token: Data){
        keychain.delete(KeychainConstants.accessToken.key)
        keychain.set(token, forKey: KeychainConstants.accessToken.key)
    }
    func saveRefreshToken(token: Data){
        keychain.delete(KeychainConstants.refreshToken.key)
        keychain.set(token, forKey: KeychainConstants.refreshToken.key)
    }

    func getPassword(for tokenKey: String) throws -> Data? {
        let result = keychain.getData(tokenKey)
        return result
    }

    func logout(for tokenKey: String) {
        print("Token deleted")
        keychain.clear()
    }
}


