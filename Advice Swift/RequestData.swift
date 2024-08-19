//
//  RequestData.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}


class RequestData {
    static func getData<T: Decodable>(requestUrl: String,
                                      onSuccess: @escaping (T) -> Void,
                                      onFailed: @escaping (Error) -> Void,
                                      onLoading: () -> Void,
                                      onFinally: (() -> Void)?,
                                      requestMethod: RequestMethod) {
        
        onLoading()
        
        let url = URL(string: requestUrl)!
        
        var request = URLRequest(url: url)
        
        print("url here!", url)
        
        request.httpMethod = requestMethod.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let error = error{
                print("Error while fetching data: ", error)
                onFailed(error)
                
                return
            }
            
            guard let data = data else {
                return
            }
            
            defer{
                onFinally?()
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedData)
                
            } catch let jsonError{
                print("failed to decode JSON", jsonError)
                onFailed(jsonError)
            }
        }
        
        task.resume()
        
    }
}
