////
////  BaseURL.swift
////  GenericsAPI
////
////  Created by Đặng Duy Cường on 1/3/20.
////  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
////
//
//import Foundation
//
//enum URLFactory: String {
//    case login
//    case chi_tiet
//    case thiet_bi
//    case diem_xung_yeu
//
//    var URL: URL {
//        func generalUrlComponent(host: String, port: Int, path: String, queryItems: [URLQueryItem]) -> URL {
//            var urlComponents = URLComponents()
//            urlComponents.scheme = "http"
//            urlComponents.host = host
//            urlComponents.port = port
//            urlComponents.path = path
//            urlComponents.queryItems = queryItems
//
//            return urlComponents.url!
//        }
//
//        //path of url
//        switch self {
//        case .chi_tiet:
//            return generalUrlComponent(host: "10.240.232.79",
//                                       port: 145,
//                                       path: "",
//                                       queryItems: [URLQueryItem(name: "", value: "")])
//        case .thiet_bi:
//            return generalUrlComponent(host: "", port: 8060, path: "", queryItems: [URLQueryItem(name: "", value: "")])
//        case .diem_xung_yeu:
//            return generalUrlComponent(host: "10.240.232.79", port: 8060, path: "/QLCTKT/rest/bts360Controller/getListCriticalPoint", queryItems: [
//                URLQueryItem(name: "fromDate", value: "04/10/2019"),
//                URLQueryItem(name: "toDate", value: "04/10/2019"),
//                URLQueryItem(name: "pageIndex", value: "0"),
//                URLQueryItem(name: "rowPage", value: "10")
//                ])
//        case .login:
//            return generalUrlComponent(host: "10.240.232.68", port: 8060, path: "/QLCTKT/rest/authen/login", queryItems: [
//                URLQueryItem(name: "username", value: "UserDefaults.standard.string(forKey: UserDefaultKeys.userName)"),
//                URLQueryItem(name: "password", value: "UserDefaults.standard.string(forKey: UserDefaultKeys.password)"),
//                URLQueryItem(name: "imeiMoblie", value: "IOS")
//                ])
//        }
//    }
//
//
//}
