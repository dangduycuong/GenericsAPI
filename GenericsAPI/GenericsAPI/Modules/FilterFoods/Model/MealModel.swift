//
//  MealModel.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation

class Meal: Codable {
    let meals: [MealElement]?
    
    init(meals: [MealElement]?) {
        self.meals = meals
    }
}

// MARK: - MealElement
class MealElement: Codable {
    let strMeal, idMeal: String?
    let strMealThumb: String?
    
    init(strMeal: String?, idMeal: String?, strMealThumb: String?) {
        self.strMeal = strMeal
        self.idMeal = idMeal
        self.strMealThumb = strMealThumb
    }
}

// MARK: - MealDetail
class MealDetail: Codable {
    let meals: [[String: String?]]?

    init(meals: [[String: String?]]?) {
        self.meals = meals
    }
}
