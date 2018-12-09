//
//  DoubleElementTableViewCell.swift
//  DummyTextField
//
//  Created by Vivan Raghuvanshi on 09/12/18.
//  Copyright © 2018 Raj Shekhar. All rights reserved.
//

import UIKit

class DoubleElementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblFloatingFirst: UILabel!
    @IBOutlet weak var textFieldFirst: UITextField!

    @IBOutlet weak var lblFloatingSecond: UILabel!
    @IBOutlet weak var textFieldSecond: UITextField!
    
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
        self.textFieldFirst.placeholder = self.getFirstFieldPlaceHolder()
        self.textFieldSecond.placeholder = self.getSecondFieldPlaceHolder()
    }
    
    private func setPlaceHoldersFor(_ textField: UITextField, WithFloatingLabelHide  hidden: Bool) {
        if textField == self.textFieldFirst {
            self.lblFloatingFirst.isHidden = hidden
            let placeHolder = self.getFirstFieldPlaceHolder()
            self.lblFloatingFirst.text = placeHolder
        } else {
            self.lblFloatingSecond.isHidden = hidden
            let placeHolder = self.getSecondFieldPlaceHolder()
            self.lblFloatingSecond.text = placeHolder
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
            self.textFieldSecond.text = "🇮🇳 INR"
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
        if textField == self.textFieldFirst {
            inputPicker?.tag = 1000
            switch self.tag {
            case 3:
                self.textFieldFirst.inputView = nil
                self.textFieldFirst.reloadInputViews()
                self.textFieldFirst.keyboardType = UIKeyboardType.numberPad
                break;
            case 4:
                self.textFieldFirst.inputView = inputPicker
                pickerArray = ["No Preference", "Fixed Budget", "Hourly Rate"]
                break;
            default:
                self.textFieldFirst.inputView = UIDatePicker()
                break;
            }
        } else {
            inputPicker?.tag = 1001
            switch self.tag {
            case 3:
                self.textFieldSecond.inputView = nil
                self.textFieldSecond.reloadInputViews()
                break;
            case 4:
                pickerArray = ["No Preference", "E-Payment", "Cash"]
                self.textFieldSecond.inputView = inputPicker
                break;
            default:
                pickerArray = ["No Preference", "Same Day", "Multi Days", "Recurring Job"]
                self.textFieldSecond.inputView = inputPicker
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
            textFieldFirst.text = title
        } else {
            textFieldSecond.text = title
        }
    }
}
