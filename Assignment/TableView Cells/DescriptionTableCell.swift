//
//  DescriptionTableCell.swift
//  DummyTextField
//
//  Created by Raj Shekhar on 08/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class DescriptionTableCell: UITableViewCell  {
  
    @IBOutlet weak var lblFloating: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var textViewDesc: PlaceholderTextView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    /// This function will update counter for remaining characters
    ///
    /// - Returns: returns an INT which holds remaining char count
    func updateCharacterCount(newChar : String?) -> Int {
        
        if var text = self.textViewDesc.text
        {
            if newChar == nil {
                
                if text.count >= 1 {
                    text = String(text.prefix(text.count - 1))
                }
            }
            else {
                text = "\(text)\(newChar!)"
            }
            let count = 500 - text.count
            self.lblMessage.text = "\(count) characters left"
            return count
        }
        return 0
    }
    

}

// MARK : Delegates of UItextView

extension DescriptionTableCell: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard let tableView = self.superview as? UITableView else {
            return
        }
        
        // Code to dynamically adjust tableVIew cell according to textView text
        let startHeight = textView.frame.size.height
        let calcHeight = textView.sizeThatFits(textView.frame.size).height  //iOS 8+ only
        
        if startHeight != calcHeight {
            
            UIView.setAnimationsEnabled(false) // Disable animations
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // Might need to insert additional stuff here if scrolls
            // table in an unexpected way.  This scrolls to the bottom
            // of the table. (Though you might need something more
            // complicated if editing in the middle.)
            
            let scrollTo = tableView.contentSize.height - tableView.frame.size.height
            
            // tableView.setContentOffset(CGPoint(0, scrollTo), animated: false)
            //this wil remove bottom border of view
            containerView.removePreviouslyAddedLayer(name: "bottomBorderLayer")
            // this will add bottom border of view
            containerView.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.5)
            
            tableView.setContentOffset(CGPoint(x: 0, y: scrollTo), animated: false)
            
        }
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.textViewDesc.placeholder = ""
            self.lblFloating.isHidden = false
            self.lblFloating.text = Text.kPostDescription
            
        }, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                textView.text = nil
                self.lblFloating.isHidden = true
                
                self.textViewDesc.placeholder = Text.kPostDescription
            }, completion: nil)
        }
        else {
            //perform action if required
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        
        
        // To check whether backspace is tapped
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        let count = self.updateCharacterCount(newChar: (isBackSpace == -92) ? nil : text)
        if (isBackSpace == -92 && count >= 0) {
            return true
        }
        
        if count <= 0{
            return false
        }
        return true
        
        
    }
}
