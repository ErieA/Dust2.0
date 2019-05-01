//
//  NetworkManager.swift
//  Dust2.0
//
//  Created by Erik Bucio on 4/29/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    private static let endpoint : String = "http://10.145.14.218:5000/api/dust/"
    
    static func checkRequirements(classes: [String : Any], completion: @escaping (Response) -> Void) {
        Alamofire.request(endpoint, method: .post, parameters: classes, encoding: JSONEncoding.default, headers: [:]).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let courseResponse = try? jsonDecoder.decode(Response.self, from: data) {
                    completion(courseResponse)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
