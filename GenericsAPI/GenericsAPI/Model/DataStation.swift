//
//  DataStation.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit

struct DataStation: Codable {
    var id: String?
    var external_id: String?
    var name: String?
}

//struct Weather: Codable {
//    var id: Int?
//    var name: String?
//    var cod: Int?
//}

struct User: Codable {
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token = ""
    }
}
