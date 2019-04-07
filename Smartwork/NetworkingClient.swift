//
//  NetworkingClient.swift
//  Smartwork
//
//  Created by Craig Newcomb on 4/5/19.
//  Copyright © 2019 Craig Newcomb. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingClient {
    
    typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
    
    func execute(method: HTTPMethod, _ url: URL, params: Parameters?, completion: @escaping WebServiceResponse) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.result.value as? [[String: Any]] {
                completion(jsonArray, nil)
            } else if let jsonDict = response.result.value as? [String: Any] {
                completion([jsonDict], nil)
            }
        }

    }
    
}
