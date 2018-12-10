//
//  SingleElementTableViewCell.swift
//  DummyTextField
//
//  Created by Raj Shekhar on 08/12/2018.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

protocol NavCategoryProtocol: class
{
    func navigateToCategoryClass(textField: UITextField)
}

class SingleElementTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFloating: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgField: UIImageView!
    
    weak var navDelegate: NavCategoryProtocol?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Helper Methods
    
    /// This function will update counter for remaining characters
    ///
    /// - Returns: returns an INT which holds remaining char count
 
    private func updateCharacterCount(newChar : String?) -> Int {
        
        if var text = self.textField.text
        {
            if newChar == nil {
                
                if text.count >= 1 {
                    text = String(text.prefix(text.count - 1))
                }
            }
            else {
                text = "\(text)\(newChar!)"
            }
            let count = 50 - text.count
            self.lblMessage.text = "\(count) characters left"
            return count
        }
        return 0
        
    }

    
    
    
    
    
    
    /// A function that will call a delegated so that controller class can navigate to category View controller
    ///
    /// - Parameter textField: Instnace of UITextField
    private func setInputViews(_ textField: UITextField) {
        
        if textField == self.textField
        {
            switch self.tag {
            case 2:
                
                self.endEditing(true)
                //textField.inputView = UIDatePicker()
                
                self.navDelegate?.navigateToCategoryClass(textField: textField)
                
                
                
                // textField.endEditing(true)
                
                break;
                
            default:
                break;
            }
            
        }
    }
    
    /// This function will set place holder text and floating label
    ///
    /// - Parameter hidden: A boolean value
    private func setPlaceHolderForFloatingLabelHide(_ hidden: Bool) {
        self.lblFloating.isHidden = hidden
        self.lblFloating.text = self.getPlaceHolderText()
        self.setPlaceHoldersForFields()
    }
    
    func setPlaceHoldersForFields() {
        self.textField.placeholder = self.getPlaceHolderText()
    }
    
    /// This function will get placholder text of textFields basis on tags
    ///
    /// - Returns: Will return placeholder string
    func getPlaceHolderText() -> String {
        var titleText = ""
        self.imgField.isHidden = false
        switch self.tag {
        case 0:
            titleText = Text.kPostTitle
            self.imgField.isHidden = true
            self.imgField.image = nil
            break;
        case 2:
            titleText = Text.kPostCategories
            self.imgField.image = #imageLiteral(resourceName: "category")
            break;
        default:
            titleText = Text.kSetLocation
            self.imgField.image = #imageLiteral(resourceName: "ic_place_white")
            break;
        }
        return titleText
    }

}


// MARK: UItextFieldDelegates
extension SingleElementTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    //Control KeyBoard While User Click on Category TextField
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == self.textField
        {
            switch self.tag {
            case 2:
                self.lblFloating.isHidden = false
                self.textField.resignFirstResponder()
                self.navDelegate?.navigateToCategoryClass(textField: textField)
                return false //KeyBoard Will Not Open
                
            default:
                break;
            }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
           
            textField.placeholder = ""
            self.lblFloating.isHidden = false
            self.lblFloating.text = "Post Categories"
           //self.setInputViews(textField)
            

        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.endEditing(true)
        if textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                textField.resignFirstResponder()
                // reset placeholder and floating label
                self.setPlaceHolderForFloatingLabelHide(true)
                
                
                
            }, completion: nil)
        }
        else {
            //perform action if required
        }
    }
    

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.textField
        {
            if self.tag == 0 {
                
                // Below code is to check whther backspace is tapped
                let  char = string.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                
                let count = self.updateCharacterCount(newChar: (isBackSpace == -92) ? nil : string)
                if (isBackSpace == -92 && count >= 0) {
                    return true
                }
                
                if count <= 0{
                    return false
                }
                return true
                
            }
        }
        return true
        
    }
    

}

