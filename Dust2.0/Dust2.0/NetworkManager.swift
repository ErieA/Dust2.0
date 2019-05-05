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
    private static let postEndpoint : String = "https://appdev-project.herokuapp.com/api/dust/"
    private static let getEndpoint : String = "https://appdev-project.herokuapp.com/api/subjects/"
    private static let numbersEndpoint : String = "https://appdev-project.herokuapp.com/api/numbers/"
    
    static func checkRequirements(classes: [String : Any], completion: @escaping (Response) -> Void) {
        Alamofire.request(postEndpoint, method: .post, parameters: classes, encoding: JSONEncoding.default, headers: [:]).validate().responseData {
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
    static func getSemesterClasses(semester: String, completion: @escaping (getResponse) -> Void) {
        let newEndpoint = getEndpoint + semester + "/"
        Alamofire.request(newEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let fields = try? jsonDecoder.decode(getResponse.self, from: data) {
                    completion(fields)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func getNumbers(semYr: String, subject: String, completion: @escaping (numberResponse) -> Void) {
        let newEndpoint = numbersEndpoint + semYr + "/" + subject
        Alamofire.request(newEndpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let numbers = try? jsonDecoder.decode(numberResponse.self, from: data) {
                    completion(numbers)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
