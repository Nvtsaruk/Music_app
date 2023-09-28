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



final class APIService {
    static let sessionManager: Session = {
        let interceptor = APIRequestInterceptor()
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, interceptor: interceptor)
    }()
    
    static func getData<T: Decodable>(_: T.Type,
                                    url: String,
                                    _ completion: @escaping (ResultRequest<T>) -> Void) {
        
        self.sessionManager.request(url, method: .get).validate().responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    print("Error", error)
            }
        }
    }
}
