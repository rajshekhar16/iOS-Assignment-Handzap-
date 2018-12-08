//
//  DemoCollectionViewCell.swift
//  Assignment
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class CategoryCollCell: UICollectionViewCell
{
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var bottomCategoryLabel: UILabel!
    @IBOutlet weak var centerCategoryLabel: UILabel!

    var isFlipped = false
    
    func updateView()
    {
        if self.isFlipped == true
        {
            bottomCategoryLabel.isHidden = true
            centerCategoryLabel.isHidden = false
        }
        else
        {
            bottomCategoryLabel.isHidden = false
            centerCategoryLabel.isHidden = true
        }
    }
    
}
