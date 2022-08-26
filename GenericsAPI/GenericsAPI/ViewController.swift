//
//  ViewController.swift
//  GenericsAPI
//
//  Created by Đặng Duy Cường on 1/3/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Alamofire
import Material

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
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var created_atLabel: UILabel!
    @IBOutlet weak var updated_atLabel: UILabel!
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataStation: DataStation?
    var dataWeather: Welcome?
    var url = "https://samples.openweathermap.org/data/3.0/stations?appid=b1b15e88fa797225412429c1c50c122a1"
    var linkURL = "https://samples.openweathermap.org/data/2.5/weather"
    var header = Dictionary<String, Any>()
    var urlQueryItem = [URLQueryItem]()
    var meals = [MealElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(MealTableViewCell.self)
        filterFoodByArea()
    }
    
    func filterFoodByArea() {
        //https://themealdb.p.rapidapi.com/filter.php?a=Canadian
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "themealdb.p.rapidapi.com"
        urlComponents.path = "/filter.php"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "a", value: "Canadian")
        ]
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            let headers: [String: String] = [
                "X-RapidAPI-Key" : "3eaa55e25cmshdb95e461cca8827p16799fjsn4425f9e011f3",
                "X-RapidAPI-Host" : "themealdb.p.rapidapi.com"
            ]
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            request.cachePolicy = .useProtocolCachePolicy
            request.timeoutInterval = 10.0
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                data?.printFormatedJSON()
                if let data = data {
                    let json = try? JSONDecoder().decode(Meal.self, from: data)
                    if let meals = json?.meals {
                        DispatchQueue.main.async {
                            self.meals = meals
                            self.tableView.reloadData()
                        }
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("error \(httpResponse.statusCode)")
                }
            }
            dataTask.resume()
        }
        
        
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
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "samples.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        
        let urlQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "London,uk"),
            URLQueryItem(name: "appid", value: "b6907d289e10d714a6e88b30761fae22"),
        ]
        
        urlComponents.queryItems = urlQueryItems
        
        if let url = urlComponents.url {
            BaseNetwork.sharedInstance.customCallAPI(url: url, method: "GET") { (data: Welcome) in
                if let weather = data.weather, !weather.isEmpty {
                    let label = UILabel()
                    self.view.layout(label)
                        .below(self.weatherButton, 32).left(16).centerX()
                    label.text = weather[0].weatherDescription
                    label.font = UIFont(name: "PlayfairDisplay-Regular", size: 18)
                    label.numberOfLines = 0
                }
            }
        }
        
        
        
//        AlamofireBase.sharedAlamofire.genericFetch(urlString: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22") { (data: Welcome) in
//            self.dataWeather = data
//            print(self.dataWeather!)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let directionVC = segue.destination as? DicrectionVC
        directionVC?.latitude = dataStation?.latitude
        directionVC?.longitude = dataStation?.longitude
        directionVC?.address = dataStation?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: MealTableViewCell.self, forIndexPath: indexPath)
        cell.loadImage(mealElement: meals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(.main).viewController(of: MealViewController.self)
        vc.meal = meals[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

