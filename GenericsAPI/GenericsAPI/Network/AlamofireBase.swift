//
//  AlamofireBase.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireBase {
    static let sharedAlamofire: AlamofireBase = AlamofireBase()
    func login(url: String, result: @escaping(String) -> Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString { response in
            switch response.result {
            case .success:
                let data = response.result.value
                result(data!)
                print(data)
            default:
                break
            }
        }
    }
    func fetchData<T: Decodable>(url: String, parameters: [String : Any], finished: @escaping (T) -> Void)  {
        Alamofire.request(
            url,
            method: .get,
            parameters: parameters
            ).debugLog().responseData { response in
                if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                    print(dataString)
                }
                guard
                    response.result.error == nil,
                    let data = response.result.value
                    else {
                        print("Error en la petición a Alamofire:\n \(String(describing: response.result.error))")
                        return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let dataObject = try decoder.decode(T.self, from: data)
                    finished(dataObject)
                } catch {
                    print("Error")
                }
        }
    }
    
    func genericFetch<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        
        Alamofire.request(urlString, method: .get).validate(statusCode: 200..<300).response { response in
            
            if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }
            
            guard response.error == nil else {
                print("error calliing on \(urlString)")
                return
            }
            
            guard let data = response.data else {
                print("there was an error with the data")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model)
            } catch let jsonErr {
                print("failed to decode, \(jsonErr)")
            }
            
        }
    }
    
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        debugPrint("=======================================")
        #endif
        return self
    }
}


