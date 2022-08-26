//
//  String+Extension.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import Foundation

extension String {
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
