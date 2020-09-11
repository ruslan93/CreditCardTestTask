//
//  ViewController.swift
//  TestTask
//
//  Created by Ruslan on 10.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expiredDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet var cardNumberTextFields: [UITextField]!

    private enum Constants {
        enum Card {
            static let cvvLenght: Int = 3
            static let numberInputLenght: Int = 4
            static let holderNameLenght: Int = 30
            static let expiredDateLenght: Int = 5

            enum Keys {
                static let holder: String = "holder"
                static let number: String = "number"
                static let expiredDate: String = "expired_date"
                static let cvv: String = "cvv"
            }
        }
        enum Error {
            static let cvv: String = "CVV is incorrect"
            static let expiredDate: String = "Expired date is incorrect"
            static let cardNumber: String = "Card number is incorrect"
        }
    }

    // MARK: - Actions
    
    @IBAction func addCardClicked() {
        view.endEditing(true)
        let cardHolder = nameTextField.text ?? ""
        let cardNumber = cardNumberTextFields.compactMap({ $0.text }).joined()
        let expiredDate = expiredDateTextField.text ?? ""
        let cvv = cvvTextField.text ?? ""

        if !CardNumberValidator().isValid(cardNumber) {
            showAlert(message: Constants.Error.cardNumber)
            return
        }
        if !ExpiredDateValidator().isValid(expiredDate) {
            showAlert(message: Constants.Error.expiredDate)
            return
        }
        if !CvvValidator().isValid(cvvTextField.text ?? "") {
            showAlert(message: Constants.Error.cvv)
            return
        }
        let jsonObject: [String: Any] = [
            Constants.Card.Keys.holder: cardHolder,
            Constants.Card.Keys.number: cardNumber,
            Constants.Card.Keys.expiredDate: expiredDate,
            Constants.Card.Keys.cvv: cvv
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) {
            showAlert(message: String(data: jsonData, encoding: .utf8) ?? "")
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            switch textField {
            case nameTextField, cvvTextField:
                return true
            case expiredDateTextField:
                if (expiredDateTextField.text ?? "").count == 4 {
                    textField.text = String((textField.text ?? "").prefix(2))
                    return false
                }
                return true
            default:
                if let inputIndex = cardNumberTextFields.firstIndex(of: textField), (textField.text?.count ?? 0) <= 1, inputIndex > 0 {
                    textField.text = ""
                    cardNumberTextFields[inputIndex - 1].becomeFirstResponder()
                    return false
                }
                return true
            }
        } else {
            switch textField {
            case nameTextField:
                return textField.text?.count ?? 0 < Constants.Card.holderNameLenght
            case cvvTextField:
                return textField.text?.count ?? 0 < Constants.Card.cvvLenght
            case expiredDateTextField:
                if (textField.text?.count ?? 0) == 2 {
                    textField.text = (textField.text ?? "") + "/" + string
                    return false
                }
                return textField.text?.count ?? 0 < Constants.Card.expiredDateLenght
            default:
                if let inputIndex = cardNumberTextFields.firstIndex(of: textField), (textField.text?.count ?? 0) + 1 == Constants.Card.numberInputLenght, inputIndex < cardNumberTextFields.count - 1 {
                    textField.text = (textField.text ?? "") + string
                    cardNumberTextFields[inputIndex + 1].becomeFirstResponder()
                    return false
                }
                return (textField.text?.count ?? 0) + 1 <= Constants.Card.numberInputLenght
            }
        }
    }
    
}
