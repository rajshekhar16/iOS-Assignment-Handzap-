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
    
    /// A delegate method to access and ask permission to use gallery
    ///
    /// - Parameters:
    ///   - accessIsAllowed: A boolean
    ///   - delegatedForm: Delegate Class
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker)
    /// A delegate method to access and ask permission to use gallery
    ///
    /// - Parameters:
    ///   - accessIsAllowed: A boolean
    ///   - delegatedForm: Delegate Class
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker)
    /// A delegate which send image and its assets to other classes that conform delegate protocol
    ///
    /// - Parameters:
    ///   - image: UIimage instance
    ///   - asset: PHAsset
    ///   - delegatedForm: Delegate Class
    
    func imagePickerDelegate(didSelect image: UIImage, asset: PHAsset, delegatedForm: ImagePicker)
    ///  delegate which send only image clicked from to other classes that conform delegate protocol
    ///
    /// - Parameters:
    ///   - image: UIimage instance
    ///   - delegatedForm: Delegate Class
    func imagePickerDelegate(didSelectFromCamera image: UIImage, delegatedForm: ImagePicker)
    
    
    /// A delegate which send only media URL to other classes that conform delegate protocol
    ///
    /// - Parameters:
    ///   - mediaURL: URL of selected media
    ///   - delegatedForm: Delegate Class
    func mediaPickerDelegate(didSelect mediaURL: URL, delegatedForm: ImagePicker)
    
    /// A delegate which cancel imagepicker
    ///
    /// - Parameter delegatedForm: Delegate class
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

// Optional Methods that's why used extension
extension ImagePickerDelegate {
    
    /// A delegate method to access and ask permission to use camera
    ///
    /// - Parameters:
    ///   - accessIsAllowed: A boolean
    ///   - delegatedForm: Delegate Class
    func imagePickerDelegate(canUseCamera accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    
    /// A delegate method to access and ask permission to use gallery
    ///
    /// - Parameters:
    ///   - accessIsAllowed: A boolean
    ///   - delegatedForm: Delegate Class
    func imagePickerDelegate(canUseGallery accessIsAllowed:Bool, delegatedForm: ImagePicker) {}
    
}

