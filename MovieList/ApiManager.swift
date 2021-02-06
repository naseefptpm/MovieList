//
//  ApiManager.swift
//  MovieList
//
//  Created by codeteki private Ltd on 23/12/20.
//

import Foundation
class ApiManager{
    static let shared = ApiManager()
    func httpGet(urlString: String!, callback: @escaping (MovieResponse?, String?) -> Void) {
       let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request){
             (data, response, error) -> Void in
             if error != nil {
                callback(nil, error?.localizedDescription)
             } else {
//                let result = String(data: data!, encoding: .ascii)
                do {
                    let result = try MovieResponse.init(data: data!)
                    callback(result, nil)
                } catch  {
                    callback(nil,"error")
                }
             }
        }
        task.resume()
    }
    
    
}
