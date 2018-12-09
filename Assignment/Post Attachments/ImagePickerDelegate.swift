//
//  ImagePickerDelegate.swift
//  DemoApp
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate {
    
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, asset: PHAsset, delegatedForm: ImagePicker)
    func mediaPickerDelegate(didSelect mediaURL: URL, delegatedForm: ImagePicker)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

extension ImagePickerDelegate {
    
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    
}
