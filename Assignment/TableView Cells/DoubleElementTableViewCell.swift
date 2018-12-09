//
//  DoubleElementTableViewCell.swift
//  DummyTextField
//
//  Created by Vivan Raghuvanshi on 09/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class DoubleElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblFloatingleft: UILabel!
    @IBOutlet weak var leftTextField: UITextField!

    @IBOutlet weak var lblFloatingRight: UILabel!
    @IBOutlet weak var rightTextField: UITextField!
    
    var inputPicker: UIPickerView?
    
    var pickerArray = [String]() {
        didSet {
            inputPicker?.reloadAllComponents()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension DoubleElementTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.setPlaceHoldersFor(textField, WithFloatingLabelHide: false)
            self.setInputViews(textField)
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                textField.text = nil
                self.setPlaceHoldersFor(textField, WithFloatingLabelHide: true)
            }, completion: nil)
        }
        else {
            //perform action if required
        }
    }
    
    func setPlaceHoldersForFields(_ picker: UIPickerView?) {
        picker?.dataSource = self
        picker?.delegate = self
        self.inputPicker = picker
        self.leftTextField.placeholder = self.getFirstFieldPlaceHolder()
        self.rightTextField.placeholder = self.getSecondFieldPlaceHolder()
    }
    
    private func setPlaceHoldersFor(_ textField: UITextField, WithFloatingLabelHide  hidden: Bool) {
        if textField == self.leftTextField {
            self.lblFloatingleft.isHidden = hidden
            let placeHolder = self.getFirstFieldPlaceHolder()
            self.lblFloatingleft.text = placeHolder
        } else {
            self.lblFloatingRight.isHidden = hidden
            let placeHolder = self.getSecondFieldPlaceHolder()
            self.lblFloatingRight.text = placeHolder
        }
        self.setPlaceHoldersForFields(inputPicker)
    }
    
    private func getFirstFieldPlaceHolder() -> String {
        var placeholderFirst = ""
        switch self.tag {
        case 3:
            placeholderFirst = "Budget"
            break;
        case 4:
            placeholderFirst = "Rate"
            break;
        default:
            placeholderFirst = "Start Date"
            break;
        }
        return placeholderFirst
    }
    
    private func getSecondFieldPlaceHolder() -> String {
        var placeholderSecond = ""
        switch self.tag {
        case 3:
            self.rightTextField.text = "🇮🇳 INR"
            placeholderSecond = "Country"
            break;
        case 4:
            placeholderSecond = "Payment Method"
            break;
        default:
            placeholderSecond = "Job Term"
            break;
        }
        return placeholderSecond
    }
    
    private func setInputViews(_ textField: UITextField) {
        if textField == self.leftTextField {
            inputPicker?.tag = 1000
            switch self.tag {
            case 3:
                self.leftTextField.inputView = nil
                self.leftTextField.reloadInputViews()
                self.leftTextField.keyboardType = UIKeyboardType.numberPad
                break;
            case 4:
                self.leftTextField.inputView = inputPicker
                pickerArray = ["No Preference", "Fixed Budget", "Hourly Rate"]
                break;
            default:
                self.leftTextField.inputView = UIDatePicker()
                break;
            }
        } else {
            inputPicker?.tag = 1001
            switch self.tag {
            case 3:
                self.rightTextField.inputView = nil
                self.rightTextField.reloadInputViews()
                break;
            case 4:
                pickerArray = ["No Preference", "E-Payment", "Cash"]
                self.rightTextField.inputView = inputPicker
                break;
            default:
                pickerArray = ["No Preference", "Same Day", "Multi Days", "Recurring Job"]
                self.rightTextField.inputView = inputPicker
                break;
            }
        }
    }
}

extension DoubleElementTableViewCell:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
}

extension DoubleElementTableViewCell:UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = pickerArray[row]
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = pickerArray[row]
        if pickerView.tag == 1000 {
            leftTextField.text = title
        } else {
            rightTextField.text = title
        }
    }
}
