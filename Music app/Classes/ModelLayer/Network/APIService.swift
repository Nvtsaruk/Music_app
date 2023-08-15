//
//  NetworkService.swift
//  Music app
//
//  Created by Tsaruk Nick on 2.08.23.
//
// spotify login 3678715@gmail.com
// pass 3678715Spotify



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
        LoginManager().refreshToken()
        
        do {
            let data = try KeychainManager.getPassword(for: "access_token")
            self.token.accessToken = String(decoding: data ?? Data(), as: UTF8.self)
            print("New token", self.token.accessToken)
        } catch {
            print(error)
        }
        var urlRequest = urlRequest
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
            if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
                // Refresh token and retry
                LoginManager().refreshToken()
            } else {
                completion(.doNotRetry)
            }
        }
}

class APIService {
    
    let interceptor = APIRequestInterceptor()
    //    let sessionManager: Session = {
    //        let configuration = URLSessionConfiguration.af.default
    ////            configuration.timeoutIntervalForRequest = 30
    ////            configuration.waitsForConnectivity = true
    //        let networkLogger = SpotifyNetworkLogger()
    //
    //        return Session(configuration: configuration, interceptor: self.interceptor, eventMonitors: [networkLogger])
    //    }()
    
    static func getData<T: Codable>(_: T.Type,
                                    url: String,
                                    _ completion: @escaping (ResultRequest<T>) -> Void) {
        
        var tempToken: String = ""
        do {
            let data = try KeychainManager.getPassword(for: "access_token")
            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
            print(tempToken)
        } catch {
            print(error)
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tempToken)"
        ]
        
        //        AF.request(url, method: .get, headers: headers).responseDecodable(of: T.self) { response in
        AF.request(url, method: .get, headers: headers, interceptor: interceptor).responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let value):
                    //                    print("here")
                    //                    print(value)
                    completion(.success(value))
                case .failure(let error):
                    // Handle the error
                    print("Error", error)
                    
            }
        }
    }
}
    
    
//    static func getPlaylist() {
//        var tempToken: String = ""
//        do {
//            let data = try KeychainManager.getPassword(for: "access_token")
//            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
//        } catch {
//            print(error)
//        }
//        let url = "https://api.spotify.com/v1/browse/featured-playlists"
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(tempToken)"
//        ]
//        AF.request(url, method: .get, headers: headers).responseDecodable(of: FeaturedPlaylists.self) { response in
//            switch response.result {
//                case .success(let value):
//                    //                     Handle the successful response
//                    guard let statusCode = response.response?.statusCode else { return }
//                    if statusCode == 401 {
//
//                        LoginManager().refreshToken()
//                        //                        APIService.getUserProfile()
//                        // interceptor
//                    }
//                    print("here")
//                    print(value)
//
//                case .failure(let error):
//                    // Handle the error
//                    print(error)
//
//            }
//
//        }
//    }


    //    func getUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
    //        var tempToken: String = ""
    //        do {
    //            let data = try KeychainManager.getPassword(for: "access_token")
    //            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
    //        } catch {
    //            print(error)
    //        }
    //        let url = "https://api.spotify.com/v1/me"
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Bearer \(tempToken)"
    //        ]
    //        let data = AF.request(url, method: .get, headers: headers).responseData { response in
    //            switch response.result {
    //            case .success(let data):
    //                do {
    //                    let decoder = JSONDecoder()
    //                    let dataModel = try decoder.decode(UserProfile.self, from: data)
    //                    DispatchQueue.main.async {
    //                        completion(.success(dataModel))
    //                    }
    //
    //                } catch {
    //                    completion(.failure(error))
    //                }
    //                case .failure(let error):
    //                    completion(.failure(error))
    //            }
    //        }
    //    }
    //    static func getUserProfile() -> CurrentUser {
    //        var tempToken: String = ""
    //        var currentUser: CurrentUser = CurrentUser(name: "") {
    //            didSet {
    //                return currentUser
    //                print(currentUser.name)
    //            }
    //        }
    //        do {
    //            let data = try KeychainManager.getPassword(for: "access_token")
    //            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
    //        } catch {
    //            print(error)
    //        }
    //        let url = "https://api.spotify.com/v1/me"
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Bearer \(tempToken)"
    //        ]
    //        let data = AF.request(url, method: .get, headers: headers).responseDecodable(of: UserProfile.self) { response in
    //            switch response.result {
    //                case .success(let value):
    ////                     Handle the successful response
    //                    guard let statusCode = response.response?.statusCode else { return }
    //                    if statusCode == 401 {
    //                        print("Token is old")
    //                        LoginManager().refreshToken()
    //                        APIService.getUserProfile()
    //                    }
    ////                    print("here")
    ////                    print(value)
    //                    currentUser.name = value.displayName
    //
    //                case .failure(let error):
    //                    // Handle the error
    //                   print(error)
    //
    //            }
    //
    //        }
    //    }
    
    //    static func getNewReleases(completion: @escaping (Result<NewReleases, Error>) -> Void) {
    //        var tempToken: String = ""
    //        do {
    //            let data = try KeychainManager.getPassword(for: "access_token")
    //            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
    //        } catch {
    //            print(error)
    //        }
    //        let url = "https://api.spotify.com/v1/browse/new-releases?limit=50&country=SE"
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Bearer \(tempToken)"
    //        ]
    //        let data = AF.request(url, method: .get, headers: headers).responseData { response in
    //            switch response.result {
    //            case .success(let data):
    //                do {
    //                    let decoder = JSONDecoder()
    //                    let dataModel = try decoder.decode(NewReleases.self, from: data)
    //                    DispatchQueue.main.async {
    //                        completion(.success(dataModel))
    //                    }
    //
    //                } catch {
    //                    completion(.failure(error))
    //                }
    //                case .failure(let error):
    //                    completion(.failure(error))
    //            }
    //        }
    //    }
    
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
