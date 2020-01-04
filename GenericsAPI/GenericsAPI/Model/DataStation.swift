//
//  DataStation.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit

struct DataStation: Codable {
    var created_at: String?
    var updated_at: String?
    var id: String?
    var external_id: String?
    var name: String?
    var longitude: Double?
    
    var latitude: Double?
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
