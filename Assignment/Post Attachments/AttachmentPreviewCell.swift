//
//  AttachmentPreviewCell.swift
//  DemoApp
//
//  Created by Raj Shekhar on 08/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class AttachmentPreviewCell: UICollectionViewCell {

    @IBOutlet weak var addAttachmentBtn: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    func resetCell()
    {
        self.addAttachmentBtn.isHidden = true
        self.previewImageView.image = nil
    }
    
}
