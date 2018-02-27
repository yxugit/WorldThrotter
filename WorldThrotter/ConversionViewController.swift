//
//  ConversionViewController.swift
//  WorldThrotter
//
//  Created by Jingwen Zhang on 2/21/18.
//  Copyright © 2018 yxu. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // MARK: UITextFieldDelegate
    // Request for input. A text field calls this method on its delegate to ask whether the replacement string should be accepted or rejected.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTexthasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil, replacementTexthasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
    
    
    // MARK: Functions
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }
        else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            //celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
        print("ConversionviewController loaded its view")
    }
}
