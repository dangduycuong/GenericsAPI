//
//  MealViewController.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Kingfisher
import Material

class MealViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var strAreaLabel: UILabel!
    @IBOutlet weak var strTagsLabel: UILabel!
    @IBOutlet weak var strInstructionsLabel: UILabel!
    
    var meal: MealElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let string = meal?.strMealThumb, let url = URL(string: string) {
            imageView.kf.setImage(with: url)
        }
        getFull()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getFull() {
        guard let id = meal?.idMeal else {
            return
        }
        let headers = [
            "X-RapidAPI-Key" : "3eaa55e25cmshdb95e461cca8827p16799fjsn4425f9e011f3",
            "X-RapidAPI-Host" : "themealdb.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://themealdb.p.rapidapi.com/lookup.php?i=\(id)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                case 200:
                    if let data = data {
                        data.printFormatedJSON()
                        let json = try? JSONDecoder().decode(MealDetail.self, from: data)
                        if let meals = json?.meals, !meals.isEmpty {
                            let item = meals[0]
                            DispatchQueue.main.async {
                                self.strAreaLabel.text = item["strArea"] as? String
                                self.strTagsLabel.text = item["strTags"] as? String
                                self.strInstructionsLabel.text = item["strInstructions"] as? String
                            }
                        }
                    }
                default:
                    print("---- failure:", httpResponse?.description)
                    break
                }
                
            }
        })
        
        dataTask.resume()
    }
    
}
