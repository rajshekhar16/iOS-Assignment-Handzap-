//
//  PostAttachmentCell.swift
//  DemoApp
//
//  Created by Raj Shekhar on 08/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import Photos

protocol AttachmentSelectionProtocol: class
{
    func openImageSelectionSheet()
    func attachmentEditButtonTapped()
}

class PostAttachmentCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIButton!

    var attachmentsArray = [UIImage]()
    
    weak var delegate:AttachmentSelectionProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: Nib.kAttachmentPreviewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.kAttachmentPreviewCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return attachmentsArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: 92, height: 92)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.kAttachmentPreviewCell, for: indexPath) as! AttachmentPreviewCell
        
        cell.layer.cornerRadius = 10
        
        cell.clipsToBounds = true
        
        cell.resetCell()
        
        if indexPath.row == 0
        {
            cell.addAttachmentBtn.isHidden = false
            cell.previewImageView.image = nil
            cell.backgroundColor = UIColor.lightGray
        }
        else
        {
            cell.addAttachmentBtn.isHidden = true
            cell.previewImageView.image = self.attachmentsArray[indexPath.row-1]
            cell.backgroundColor = UIColor.white
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            self.delegate?.openImageSelectionSheet()
        }
    }
    
    @IBAction func editButtonTapped(sender: UIButton)
    {
        self.delegate?.attachmentEditButtonTapped()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
