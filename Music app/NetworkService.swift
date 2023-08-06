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

class NetworkService {
    static func getData() {
        AF.request("https://www.google.com").response { response in
            switch response.result {
                case .success(let value):
                    // Handle the successful response
                    debugPrint(value)
                case .failure(let error):
                    // Handle the error
                    print(error)
            }
        }
    }
}
