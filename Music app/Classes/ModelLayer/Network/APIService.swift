import Foundation
import Alamofire

enum ResultRequest<T> {
    case success(T)
    case failure(CustomErrors)
}

struct Token {
    var accessToken: String
}
enum CustomErrors: String, Error {
    case receivedError = "Received Error"
    case linkError = "Link Error"
    case dataError = "Data Error"
    case jsonDecodeError = "Json Decode Error"
}

class APIRequestInterceptor: RequestInterceptor {
    private var token: Token = Token(accessToken: "")
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        do {
            let data = try KeychainManager.getPassword(for: KeychainConstants.accessToken.key)
            self.token.accessToken = String(decoding: data ?? Data(), as: UTF8.self)
        } catch {
            print(error)
        }
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: token.accessToken))
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, let responseError = error.asAFError, response.statusCode == 401 || response.statusCode == 400 || responseError.isResponseSerializationError {
            // Refresh token and retry
            print("In token condition")
//            DispatchQueue.main.async {
                LoginManager().refreshToken()
//            }
            
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
//        if let , response.isResponseSerializationError {
//            print("In error condition")
//            LoginManager().refreshToken()
//            completion(.retry)
//        }
    }
}

class APIService {
    
    
    static let sessionManager: Session = {
        let interceptor = APIRequestInterceptor()
        let configuration = URLSessionConfiguration.af.default
        //            let networkLogger = SpotifyNetworkLogger()
        
        //            return Session(configuration: configuration, interceptor: interceptor, eventMonitors: [networkLogger])
        return Session(configuration: configuration, interceptor: interceptor)
    }()
    
    static func getData<T: Codable>(_: T.Type,
                                    url: String,
                                    _ completion: @escaping (ResultRequest<T>) -> Void) {
        
        self.sessionManager.request(url, method: .get).responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let value):
                    print("Value", value)
                    completion(.success(value))
                case .failure(let error):
                    // Handle the error
                    //                    LoginManager().refreshToken()
                    print("Error", error)
                    
            }
        }
    }
}

class SpotifyNetworkLogger: EventMonitor {
    //1
    let queue = DispatchQueue(label: "com.raywenderlich.gitonfire.networklogger")
    //2
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    //3
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
