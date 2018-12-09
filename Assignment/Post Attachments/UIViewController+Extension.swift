//
//  UIViewController+Extension.swift
//  DemoApp
//
//  Created by Raj Shekhar on 08/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension UIViewController
{
    func showAlert(message: String)
    {
        let alert = UIAlertController.init(title: "Alert", message: message, preferredStyle: .alert )
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
