//
//  UIViewController+Extension.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit

//
// MARK: - Default Implementation for Identifier
extension UIViewController: Identifier {
    
    /// ID View
    static var identifierView: String {
        get {
            return String(describing: self)
        }
    }
    
    /// XIB
    static func xib() -> UINib? {
        return UINib(nibName: self.identifierView, bundle: nil)
    }
}
