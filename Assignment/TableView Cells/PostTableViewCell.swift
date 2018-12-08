//
//  PostTableViewCell.swift
//  Assignment
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleFloatLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PostTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.endEditing(true)
        return false
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // animate and show floating label as soon you click on text Field
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.titleTextField.placeholder = ""
            
            self.titleFloatLabel.text = "Post Title"
            
        }, completion: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" {
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                
                self.titleTextField.text = ""
                
                self.titleTextField.placeholder = "Enter Post Title"
                
                self.titleFloatLabel.isHidden = true
                
            }, completion: nil)
            
        }
            
        else {
            
            //perform action if required
            
        }
        
    }
    
}

