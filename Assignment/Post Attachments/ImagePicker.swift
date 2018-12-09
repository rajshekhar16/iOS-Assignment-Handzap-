//
//  ImagePicker.swift
//  DemoApp
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ImagePicker: NSObject {
    
    var controller = UIImagePickerController()
    var selectedImage: UIImage?
    var delegate: ImagePickerDelegate? = nil
    
    override init() {
        super.init()
        controller.sourceType = .photoLibrary
        controller.delegate = self
    }
    
    func dismiss() {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ImagePicker {
    
    func cameraAsscessRequest() {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            delegate?.imagePickerDelegate(canUseCamera: true, delegatedForm: self)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted -> Void in
                self.delegate?.imagePickerDelegate(canUseCamera: granted, delegatedForm: self)
            }
        }
    }
    
    func galleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            if let _self = self {
                var access = false
                if result == .authorized {
                    access = true
                }
                _self.delegate?.imagePickerDelegate(canUseGallery: access, delegatedForm: _self)
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       // let imageName = "img_\(Date().timeIntervalSince1970)"
        var asset = PHAsset()
        if #available(iOS 11.0, *) {
            if let inAsset =  info[UIImagePickerController.InfoKey.phAsset] as? PHAsset
            {
                asset = inAsset
            }
            
            
        } else {
            if let assetURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
                let result = PHAsset.fetchAssets(withALAssetURLs: [assetURL], options: nil)
                asset = result.firstObject ?? asset
            }
        }
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            
            if mediaType  == "public.image" {
                if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    delegate?.imagePickerDelegate(didSelect: image, asset: asset,  delegatedForm: self)
                }
                else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    delegate?.imagePickerDelegate(didSelect: image, asset: asset, delegatedForm: self)
                }
                else{
                    print("Unable to pick media")
                }
            }
            
            if mediaType == "public.movie" {
                if let mediaURL =  info[UIImagePickerController.InfoKey.mediaURL] as? URL
                {
                    print(mediaURL)
                    delegate?.mediaPickerDelegate(didSelect: mediaURL, delegatedForm: self)
                }
                
            }
        }
        

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }
    
}
