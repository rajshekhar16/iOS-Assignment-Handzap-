//
//  PlaceHoldeTextView.swift
//  Assignment
//
//  Created by Raj Shekhar on 09/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

import UIKit

private let kPlaceholderTextViewInsetSpan: CGFloat = 8

public class PlaceholderTextView: UITextView {
    let placeholderLeftMargin: CGFloat = 4.0
    let placeholderTopMargin: CGFloat = 8.0
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.alpha = 1.0
        return label
    }()
    
    @IBInspectable
    public var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable
    public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
            placeholderSizeToFit()
        }
    }
    
    override public var text: String! {
        didSet {
            textChanged(nil)
        }
    }
    
    override public var font: UIFont? {
        didSet {
            placeholderLabel.font = font
            placeholderSizeToFit()
        }
    }
    
    fileprivate func placeholderSizeToFit() {
        placeholderLabel.frame = CGRect(x: placeholderLeftMargin, y: placeholderTopMargin, width: frame.width - placeholderLeftMargin * 2, height: 0.0)
        placeholderLabel.sizeToFit()
    }
    
    fileprivate func setup() {
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        font = UIFont.systemFont(ofSize: 15.0)
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.text = placeholder
        placeholderSizeToFit()
        addSubview(placeholderLabel)
        
        self.sendSubviewToBack(placeholderLabel)
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(PlaceholderTextView.textChanged(_:)), name: UITextView.textDidChangeNotification, object: nil)
        
        textChanged(nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, textContainer: nil)
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    @objc func textChanged(_ notification:Notification?) {
        placeholderLabel.alpha = self.text.isEmpty ? 1.0 : 0.0
    }
}
