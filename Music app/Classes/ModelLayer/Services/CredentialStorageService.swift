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
        guard let resultTemp = result else { return Data()}
//        print("qweqweqeqe", String(data: resultTemp, encoding: .utf8))
        return result
    }

    func logout(for tokenKey: String) {
        print("Token deleted")
        keychain.clear()
    }
    
//    func save(token: Data, tokenKey: String) throws -> String {
////        keychain.set(token, forKey: tokenKey)
//        let query: [CFString: Any] = [
//            kSecClass: kSecClassInternetPassword,
//            kSecAttrAccount: tokenKey,
//            kSecValueData: token
//        ]
//
//        let status = SecItemAdd(query as CFDictionary, nil)
//
//        guard status != errSecDuplicateItem else {
//            throw KeychainError.duplicateItem
//        }
//
//        guard status == errSecSuccess else {
//            throw KeychainError.unknown(status: status)
//        }
//
//        return "Saved"
//    }
//
//    func getPassword(for tokenKey: String) throws -> Data? {
////        let tempResult = keychain.getData(tokenKey)
////                print("Token key", tokenKey)
////                print("Keychain token", tempResult)
//        let query: [CFString: Any] = [
//            kSecClass: kSecClassInternetPassword,
//            kSecAttrAccount: tokenKey,
//            kSecReturnData: kCFBooleanTrue as Any
//        ]
//
//        var result: AnyObject?
//
//        let status = SecItemCopyMatching(query as CFDictionary, &result)
//
//        guard status == errSecSuccess else {
//            throw KeychainError.unknown(status: status)
//        }
//
//        return result as? Data
//    }
//    func logout(for tokenKey: String) throws -> String {
//        let query: [CFString: Any] = [
//            kSecClass: kSecClassInternetPassword,
//            kSecAttrAccount: tokenKey,
//            kSecReturnData: kCFBooleanTrue as Any
//        ]
//        SecItemDelete(query as CFDictionary)
//        return "deleted"
//    }
}

// singleton
//class Singleton {
//    static var singleton = Singleton()
//    private init(){}
//}
