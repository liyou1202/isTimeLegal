//
//  ViewController.swift
//  isTimeLegal
//
//  Created by 陳禮佑 on 2023-12-11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let timePickerView: UIPickerView = UIPickerView()
    let inputPickerView: UIPickerView = UIPickerView()
    var timePickerContents: [String] = []
    var inputPickerContents: [String] = []
    var activeTextField: UITextField?
    
    var gameRecords: [GameRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillPickerContent()
        timePickerView.delegate = self
        timePickerView.dataSource = self
        inputPickerView.delegate = self
        inputPickerView.dataSource = self
        
        startTextField.inputView = timePickerView
        startTextField.textAlignment = .center
        startTextField.delegate = self
        
        endTextField.inputView = timePickerView
        endTextField.textAlignment = .center
        endTextField.delegate = self
        
        inputTextField.inputView = inputPickerView
        inputTextField.textAlignment = .center
        inputTextField.delegate = self
    }
    
    func fillPickerContent() {
        for i in 1..<25 {
            timePickerContents.append(String (format:  "%02d:00" , i))
            inputPickerContents.append("\(i)")
        }
    }
    
    //Check all Textfield has been filled then return [Start, End, Input] String values otherwise return empty array.
    func getTextFiledValues() -> [String] {
        let emptyArray: [String] = []
        guard let startText = startTextField.text else {return emptyArray}
        guard let endText = endTextField.text else {return emptyArray}
        guard let inputText = inputTextField.text else {return emptyArray}
        if startText.isEmpty || endText.isEmpty || inputText.isEmpty {
            return emptyArray
        }
        
        var resultArray: [String] = []
        if let startHour = reductionTimePickerContent(str: startText) {
            resultArray.append(startHour)
        }
        if let endHour = reductionTimePickerContent(str: endText) {
            resultArray.append(endHour)
        }
        resultArray.append(inputText)
        
        if resultArray.count != 3 {
            return emptyArray
        }
        
        return resultArray
    }
    
    func reductionTimePickerContent(str: String) -> String? {
        let components = str.components(separatedBy: ":")
        if components.count == 2 {
            return components[0]
        }
        
        return nil
    }
    
    @IBAction func validateButtonDidTouch(_ sender: Any) {
        // [StartHour, EndHour, InputHour]
        let values = getTextFiledValues()
        if values.count < 3 {
            resultLabel.text = "Error: Empty text field"
            return
        }
        let start = Int(values[0])!
        let end = Int(values[1])!
        let input = Int(values[2])!
        
        let isTimeLegal = validateRange(start: start, end: end, input: input)
        let record = GameRecord(start: startTextField.text!, end: endTextField.text!, input: inputTextField.text!, result: isTimeLegal)
        gameRecords.append(record)
        
        if isTimeLegal {
            resultLabel.text = "True: \(input) is included"
            return
        }
        
        resultLabel.text = "False: \(input) is not included"
    }
    
    func validateRange(start: Int, end: Int, input: Int) -> Bool {
        if start == input {
            return true
        }
        
        if start < end {
            if (start < input && input < end) {
                return true
            }
            return false
        }
        
        if (input > start || input < end) {
            return true
        }

        return false
    }
    
    @IBAction func historyButtonDidTouch(_ sender: Any) {
        print(gameRecords)
    }
    
}

// Picker Delegate
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let textField = activeTextField else {return timePickerContents.count}
        if textField == inputTextField {
            return inputPickerContents.count
        }
        
        return timePickerContents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let textField = activeTextField else {return timePickerContents[row]}
        if textField == inputTextField {
            return inputPickerContents[row]
        }
        
        return timePickerContents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let textField = activeTextField else {return}
        self.view.endEditing(true)
        if textField == inputTextField {
            textField.text = inputPickerContents[row]
            return
        }
        
        textField.text = timePickerContents[row]
    }
}

// TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
