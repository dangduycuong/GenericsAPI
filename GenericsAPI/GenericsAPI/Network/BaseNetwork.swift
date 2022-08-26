//
//  BaseNetwork.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit

class BaseNetwork {
    
    static let sharedInstance: BaseNetwork = BaseNetwork()
    
    //một function có chứa generic type sẽ có kiểu như này.
    func getData<T: Codable>(urlString: String, completion: @escaping(T)->()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            if let data = data {
                print("fullURLRequest: ", url)
                print("params: ", url.query)
                print("header: ", url.relativeString)
                data.printFormatedJSON()
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch let error {
                print("decode error: ", error)
            }
        }.resume()
    }
    
    func getDataFromAPI<T: Codable>(url: URL, completion: @escaping(T)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(data)
                    print("urlRequest: ", url)
//                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                        print("Response json:\n", dataString)
//                    }
                }
            } catch let error {
                print("decode error: ", error)
            }
            }.resume()
    }
    
    func customCallAPI<T: Codable>(url: URL, method: String, completion: @escaping(T)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    //                if let data = data1, let dataString = String(data: data, encoding: .utf8) {
                    //                    print("fullURLRequest: ", url)
                    //                    print("params: ", url.query)
                    //                    print("header: ", url.absoluteString)
                    //                    print("Response json:\n", dataString)
                    //                }
                    
                    data.printFormatedJSON()
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch let error {
                    print("decode error: ", error)
                }
            }
        }
        dataTask.resume()
    }
    
    func login(url: URL, completion: @escaping(String) -> Void) {
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data1, response, error in
            if let data = data1, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
            }
            do {
            }
        }
        dataTask.resume()
    }

}


import Foundation

extension Data {
    
    func printResponseJson() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
    
    func printFormatedJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            pringJSONData(jsonData)
        } else {
            assertionFailure("Malformed JSON")
        }
    }
    
    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
}
