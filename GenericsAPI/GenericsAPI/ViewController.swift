//
//  ViewController.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Alamofire

enum CallAPIType: Int {
    case thoi_tiet = 0
    case ban_do_thoi_tiet = 1
    case danh_sach_users = 2
    
    static var all = [thoi_tiet, ban_do_thoi_tiet, danh_sach_users]
    
    var text: String {
        get {
            switch self {
            case .thoi_tiet:
                return "Lấy drop bài test"
            case .ban_do_thoi_tiet:
                return "Thực hiện đo kiểm"
            case .danh_sach_users:
                return "Thực hiện đo kiểm"
            }
        }
    }
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var created_atLabel: UILabel!
    @IBOutlet weak var updated_atLabel: UILabel!
    
    
    
    
    var dataStation: DataStation?
    var dataWeather: Welcome?
    var url = "https://samples.openweathermap.org/data/3.0/stations?appid=b1b15e88fa797225412429c1c50c122a1"
    var linkURL = "https://samples.openweathermap.org/data/2.5/weather"
    var header = Dictionary<String, Any>()
    var urlQueryItem = [URLQueryItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func disPlayDataStation() {
        nameLabel.text = dataStation?.name ?? " "
        created_atLabel.text = dataStation?.created_at ?? " "
        updated_atLabel.text = dataStation?.updated_at ?? ""
    }
    
    func validateValueParams() {
        urlQueryItem.removeAll()
        
        urlQueryItem = [
        URLQueryItem(name: "q", value: "London,uk"),
        URLQueryItem(name: "appid", value: "b6907d289e10d714a6e88b30761fae22")
        ]
    }
    
    func generalUrlComponent(host: String, port: Int, path: String, queryItems: [URLQueryItem], header: Dictionary<String, Any>) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
    
    
    
    func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url?.absoluteString
    }
    

    
    func callAPI() {
        validateValueParams()
        BaseNetwork.sharedInstance.getData(urlString: url) { (data: DataStation) in
            self.dataStation = data
        }
    }
    
    // MARK: ACTIONS
    @IBAction func printDataStation(_ sender: UIButton) {
        BaseNetwork.sharedInstance.getData(urlString: url) { (data: DataStation) in
            self.dataStation = data
            self.disPlayDataStation()
        }
    }
    
    @IBAction func printWeather(_ sender: UIButton) {
//        BaseNetwork.sharedInstance.customCallAPI(url: URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22")!, method: "GET") { (data: Welcome) in
//
//        }
        
//        BaseNetwork.sharedInstance.getData(urlString: "http://ksan.neo.vn/a2/api?ServiceType=value&Service=login_service_mobile&Provider=default&ParamSize=3&P1=longnvneo&P2=25d55ad283aa400af464c76d713c07ad&P3=140146ab319b28b1") { (data: User) in
//            
//        }
//        let urlQueryItem: [URLQueryItem] = [
//            URLQueryItem(name: "ServiceType", value: "value"),
//            URLQueryItem(name: "Service", value: "login_service_mobile"),
//            URLQueryItem(name: "Provider", value: "default"),
//            URLQueryItem(name: "ParamSize", value: "3"),
//
//            URLQueryItem(name: "P1", value: "longnvneo"),
//            URLQueryItem(name: "P2", value: "25d55ad283aa400af464c76d713c07ad"),
//            URLQueryItem(name: "P3", value: "140146ab319b28b1")
//        ]
//
//        let urlComponents = NSURLComponents(string: "http://ksan.neo.vn/a2/api")!
//        urlComponents.queryItems = urlQueryItem
//        let url = urlComponents.url!
//
//        BaseNetwork.sharedInstance.login(url: url) { data in
//
//        }
        
        
        
        AlamofireBase.sharedAlamofire.genericFetch(urlString: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22") { (data: Welcome) in
            self.dataWeather = data
            print(self.dataWeather!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let directionVC = segue.destination as? DicrectionVC
        directionVC?.latitude = dataStation?.latitude
        directionVC?.longitude = dataStation?.longitude
        directionVC?.address = dataStation?.name
    }
    
}

