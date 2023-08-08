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

class APIService {
    static func getUserProfile() {
        var tempToken: String = ""
        do {
            let data = try KeychainManager.getPassword(for: "access_token")
            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
        } catch {
            print(error)
        }
        let url = "https://api.spotify.com/v1/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tempToken)"
        ]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: UserProfile.self) { response in
            switch response.result {
                case .success(let value):
//                     Handle the successful response
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode == 401 {
                        print("Token is ald")
                        LoginManager().refreshToken()
                        APIService.getUserProfile()
                    }
                    print("here")
                    print(value)

                case .failure(let error):
                    // Handle the error
                   print(error)

            }
            
        }
    }
    static func getPlaylist() {
        var tempToken: String = ""
        do {
            let data = try KeychainManager.getPassword(for: "access_token")
            tempToken = String(decoding: data ?? Data(), as: UTF8.self)
        } catch {
            print(error)
        }
        let url = "https://api.spotify.com/v1/browse/featured-playlists"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(tempToken)"
        ]
        AF.request(url, method: .get, headers: headers).responseDecodable(of: FeaturedPlaylists.self) { response in
            switch response.result {
                case .success(let value):
//                     Handle the successful response
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode == 401 {
                        
                        LoginManager().refreshToken()
                        APIService.getUserProfile()
                    }
                    print("here")
                    print(value)

                case .failure(let error):
                    // Handle the error
                   print(error)

            }
            
        }
    }
}

