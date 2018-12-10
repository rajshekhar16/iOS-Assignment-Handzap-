//
//  DoubleElementTableViewCell.swift
//  DummyTextField
//
//  Created by Raj Shekhar on 09/12/18.
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
    
    
    /// This will set placeholder text
    ///
    /// - Parameter picker: Instance of UIPickerView
    func setPlaceHoldersForFields(_ picker: UIPickerView?) {
        picker?.dataSource = self
        picker?.delegate = self
        self.inputPicker = picker
        self.leftTextField.placeholder = self.getFirstFieldPlaceHolder()
        self.rightTextField.placeholder = self.getSecondFieldPlaceHolder()
    }
    
    /// This function will hide/show floating label for a textfield
    ///
    /// - Parameters:
    ///   - textField: INstance of TextField
    ///   - hidden: Boolean value
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
    
    
    // Functionn to get the placeholder text of first textfield i.e left
    private func getFirstFieldPlaceHolder() -> String {
        var placeholderFirst = ""
        switch self.tag {
        case 3:
            placeholderFirst = Text.kBudget
            break;
        case 4:
            placeholderFirst = Text.kRate
            break;
        default:
            placeholderFirst = Text.kStartDate
            break;
        }
        return placeholderFirst
    }
    
    // Functionn to get the placeholder text of second textfield i.e right
    private func getSecondFieldPlaceHolder() -> String {
        var placeholderSecond = ""
        switch self.tag {
        case 3:
            self.rightTextField.text = "🇮🇳 INR"
            placeholderSecond = Text.kCountry
            break;
        case 4:
            placeholderSecond = Text.kPaymentMethod
            break;
        default:
            placeholderSecond = Text.kJobTerm
            break;
        }
        return placeholderSecond
    }
    
    /// This will set pickerview as input view of textfield. Recognizing different textfielf on the basis of tags
    ///
    /// - Parameter textField: Instance of UITextfield
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
                pickerArray = [Text.kNoPreference, Text.kFixedBudget, Text.kHourlyRate]
                break;
            default:
                
                self.leftTextField.inputView = inputPicker
                let cal = Calendar.current
                var date = cal.startOfDay(for: Date())
                let dateFormatter = DateFormatter()
                
                // Following few lines will add upcoming 7 days to an array
                dateFormatter.dateFormat = "EEEE  d  yyy"
                for _ in 1 ... 7 {
                    pickerArray.append(dateFormatter.string(from: date))
                    date = cal.date(byAdding: .day, value: 1, to: date)!
                }
                //Your New Date format as per requirement change it own
                //pass Date here
                
                print(date)
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
                pickerArray = [Text.kNoPreference, Text.kEPayment, Text.kCash]
                self.rightTextField.inputView = inputPicker
                break;
            default:
                pickerArray = [Text.kNoPreference, Text.kSameDay, Text.kMultiDays, Text.kRecurringJob]
                self.rightTextField.inputView = inputPicker
                break;
            }
        }
    }

}

// MARK: TextField Delegate Methods
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
    
    
}

// MARK: DataSource of UIPickerView

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
