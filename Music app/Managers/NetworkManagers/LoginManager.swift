import Alamofire

struct TokenRequest:Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
}

class LoginManager {
    static let shared = LoginManager()
    
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
                // Handle the successful response
                    print("Data from responce", value.access_token)
                    guard let accessToken = value.access_token.data(using: .utf8) else { return }
                    guard let refreshToken = value.refresh_token.data(using: .utf8) else { return }
                    do {
                       let status = try KeychainManager.save(token: accessToken, tokenKey: "access_token")
                    } catch {
                        print(error)
                    }
                    do {
                       let status = try KeychainManager.save(token: refreshToken, tokenKey: "refresh_token")
                    } catch {
                        print(error)
                    }
                    
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
//        print(KeychainManager.getPassword(for: "access_token"))
//        print("Data from keychain", KeychainManager.shared.loadDataFromKeychain(key: "access_token"))
        
    }
}
