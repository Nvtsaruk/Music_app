import Security
import Foundation

enum KeychainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}

final class KeychainManager {
    static func save(token: Data, tokenKey: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: tokenKey,
            kSecValueData: token
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return "Saved"
    }
    
    static func getPassword(for tokenKey: String) throws -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: tokenKey,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return result as? Data
    }
    static func logout(for tokenKey: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassInternetPassword,
            kSecAttrAccount: tokenKey,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        SecItemDelete(query as CFDictionary)
        return "deleted"
    }
}
