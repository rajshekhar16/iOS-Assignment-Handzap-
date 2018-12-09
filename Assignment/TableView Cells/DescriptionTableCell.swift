//
//  DescriptionTableCell.swift
//  DummyTextField
//
//  Created by Vivan Raghuvanshi on 08/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class DescriptionTableCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var lblFloating: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var textViewDesc: PlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let parentVC = self.parentViewController else { return }
        
        let size = CGSize(width: parentVC.view.frame.width - 30, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.textViewDesc.placeholder = ""
            self.lblFloating.isHidden = false
            self.lblFloating.text = "Post Description"
            
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                textView.text = nil
                self.lblFloating.isHidden = true
                
                self.textViewDesc.placeholder = "Post Description"
            }, completion: nil)
        }
        else {
            //perform action if required
        }
    }
}
