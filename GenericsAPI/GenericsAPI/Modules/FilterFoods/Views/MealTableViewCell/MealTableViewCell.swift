//
//  MealTableViewCell.swift
//  GenericsAPI
//
//  Created by cuongdd on 26/08/2022.
//  Copyright © 2022 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import Kingfisher

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadImage(mealElement: MealElement) {
        nameLabel.text = mealElement.strMeal
        guard let string = mealElement.strMealThumb, let url = URL(string: string) else {
            return
        }
        let placeholderImage = UIImage()
        imageView?.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        
    }
    
}
