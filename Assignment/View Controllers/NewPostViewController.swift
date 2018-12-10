//
//  ViewController.swift
//  Assignment
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import Photos
import CoreServices


class NewPostViewController: UITableViewController, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var picker:UIPickerView!
    
    var attachments = [UIImage]()
    
    var categoryTextField:UITextField?
    
    fileprivate var imagePicker = ImagePicker()

    


    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableView.register(UINib.init(nibName: Nib.kPostAttachmentCell, bundle: nil), forCellReuseIdentifier: Identifier.kPostAttachmentCell)
        
        self.title = Text.kNewPostTitle
        
        self.tableView.keyboardDismissMode = .onDrag
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(savePost))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        

        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func savePost()
    {
        // add code to save post
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: Identifier.kDescriptionTableCell) as? DescriptionTableCell {
                descriptionCell.textViewDesc.isScrollEnabled = false
                descriptionCell.textViewDesc.translatesAutoresizingMaskIntoConstraints = false
                descriptionCell.tag = indexPath.row
                return descriptionCell
            }
        } else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.kDoubleElementTableViewCell, for: indexPath) as? DoubleElementTableViewCell {
                cell.tag = indexPath.row
                cell.setPlaceHoldersForFields(picker)
                return cell
            }
        }
        else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.kPostAttachmentCell, for: indexPath) as! PostAttachmentCell
            cell.delegate = self
            
            if cell.attachmentsArray.count == 0
            {
                cell.editButton.isHidden = true
            }
            else
            {
                cell.editButton.isHidden = false
            }
            
            cell.attachmentsArray = self.attachments
            cell.collectionView.reloadData()
            return cell
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.kSingleElementTableViewCell, for: indexPath) as? SingleElementTableViewCell {
                cell.tag = indexPath.row
                cell.setPlaceHoldersForFields()
                cell.navDelegate = self
                
                return cell
            }
        }
        return UITableViewCell()
    }
    


}

// MARK: ATTAchment protocol methods

extension NewPostViewController: AttachmentSelectionProtocol {
   
    func attachmentEditButtonTapped() {
        
    }
    
    func openImageSelectionSheet() {
       
        let actionSheet = UIAlertController.init(title: Text.kSelectAttachmentSource, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: Text.kCamera, style: .default, handler: { _ in
            //self.openLibrary()
            self.imagePicker.cameraAsscessRequest()
        }))
        actionSheet.addAction(UIAlertAction.init(title: Text.kPandVLibrary, style: .default, handler: { _ in
            // self.presentImagePicker(sourceType: .photoLibrary)
            self.imagePicker.galleryAsscessRequest()
        }))
        actionSheet.addAction(UIAlertAction.init(title: Text.kDocument, style: .default, handler: { _ in
            self.showAlert(message: "\(Text.kDocument) is in Progress")
        }))
        actionSheet.addAction(UIAlertAction.init(title: Text.kCancel, style: .cancel, handler: { (_) in
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension NewPostViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7
        {
            return 140.0
        }
        return UITableView.automaticDimension

    }
}

extension NewPostViewController : NavCategoryProtocol{
    
    func navigateToCategoryClass(textField: UITextField) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Identifier.kCategoryViewController) as! CategoryViewController
        nextViewController.delegate = self
      
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        categoryTextField = textField
       
    }
}

extension NewPostViewController : CategorySelectionProtocol{
    
    func didSelectCategories(categoriesSelected: Int) {
        
        categoryTextField?.text = "\(categoriesSelected) Categories Selected"
    }
}

// MARK: Delegates of ImagePicker

extension NewPostViewController: ImagePickerDelegate
{
    func imagePickerDelegate(didSelectFromCamera image: UIImage, delegatedForm: ImagePicker) {
        self.attachments.append(image)
        imagePicker.dismiss()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func imagePickerDelegate(didSelect image: UIImage, asset: PHAsset, delegatedForm: ImagePicker)
    {
        let image = self.getAssetThumbnail(asset: asset)
        self.attachments.append(image)
        
        imagePicker.dismiss()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func mediaPickerDelegate(didSelect mediaURL: URL, delegatedForm: ImagePicker) {
        self.captureThumbnail(withVideoURL: mediaURL, secs: 10, preferredTimeScale: 1) { (image) in
            
            if let image = image  {
                self.attachments.append(image)
                self.imagePicker.dismiss()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
        }
        
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        imagePicker.dismiss()
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed {
            presentImagePicker(sourceType: .photoLibrary)
        }
    }
    
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed {
            // works only on real device (crash on simulator)
            presentImagePicker(sourceType: .camera)
        }
    }
    
    func captureThumbnail(withVideoURL videoURL:URL,secs:Int,preferredTimeScale scale:Int,completionHandler:((UIImage?) ->Void)?) -> Void
    {
        //let seconds : Int64 = 10
        // let preferredTimeScale : Int32 = 1
        
        DispatchQueue.global().async {
            
            do
            {
                let asset = AVURLAsset(url: videoURL)
                
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImage(at:CMTimeMake(value: Int64(secs), timescale: Int32(scale)),actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                completionHandler?(thumbnail)
            }
            catch let error as NSError
            {
                print("Error generating thumbnail: \(error)")
                completionHandler?(nil)
            }
        }
    }
    
    fileprivate func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.controller.sourceType = sourceType
        imagePicker.controller.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        DispatchQueue.main.async {
            self.present(self.imagePicker.controller, animated: true, completion: nil)
        }
    }
    
}


