//
//  UIStoryboard+Extension.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func storyBoard(_ storyboard: UIStoryboardType) -> UIStoryboard {
        return UIStoryboard(name: storyboard.identifier, bundle: nil)
    }
    
    func viewController<T: UIViewController>(of type: T.Type) -> T {
        guard let viewController =  instantiateViewController(withIdentifier: T.identifierView) as? T else {
            fatalError("Unabble to instantiate '\(T.identifierView)' ")
        }
        return viewController
    }
    
}

// MARK: Storyboard Type
enum UIStoryboardType {
    
    case main
    case myLoads
    case activeStop
    case documents
    case dashboard
    case base
    case geniusScan
    
    var identifier: String {
        switch self {
        case .main:
            return "Main"
        case .myLoads:
            return "MyLoads"
        case .activeStop:
            return "ActiveStop"
        case .documents:
            return "Documents"
        case .dashboard:
            return "Dashboard"
        case .base:
            return "Base"
        case .geniusScan:
            return "GeniusScan"
        }
    }
}
