//
//  ViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 2/2/24.
//

import UIKit

final class SettingViewController: UIViewController {
    
    // MARK: - Public Properties
    @IBOutlet var rectangleView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    var color: UIColor!
    unowned var delegate: SettingViewControllerDelegate!
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueTF, greenValueTF, blueValueTF)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        setRectangleColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redValueTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenValueTF)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueValueTF)
        }
        
        setRectangleColor()
    }

    @IBAction func doneButtonAction() {
        view.endEditing(true)
        delegate?.setColor(rectangleView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension SettingViewController {
    
    func setRectangleColor() {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: label.text = string(from: redSlider)
            case greenValueLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF: textField.text = string(from: redSlider)
            case greenValueTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    func setValue(for sliders: UISlider...) {
        let ciColor = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = ciColor.red.float()
            case greenSlider: greenSlider.value = ciColor.green.float()
            default: blueSlider.value = ciColor.blue.float()
            }
        }
    }
    
    func showAlert(
        withTitle title: String,
        andMessage message: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default) {_ in
            completion?()
        }
        
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text, textField.text != "" else {
            setValue(for: textField)
            return
        }
        
        if let range = text.range(of: ".") {
            let decimalPart = text[range.upperBound...]
            if decimalPart.count > 2 {
                return showAlert(
                    withTitle: "Не верный формат",
                    andMessage: "После запятой не должно быть больше двух цифр") {
                        self.setValue(for: textField)
                        textField.becomeFirstResponder()
                    }
            }
        }
        
        guard let numberTF = Float(text), (0...1).contains(numberTF) else {
            showAlert(
                withTitle: "Неверное число",
                andMessage: "Число должно быть от 0.00 до 1.00"
            ) {
                self.setValue(for: textField)
                textField.becomeFirstResponder()
            }
            return
        }
        
        switch textField {
        case redValueTF:
            redSlider.setValue(numberTF, animated: true)
            setValue(for: redValueLabel)
        case greenValueTF:
            greenSlider.setValue(numberTF, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(numberTF, animated: true)
            setValue(for: blueValueLabel)
        }
        setRectangleColor()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "done",
            style: .done,
            target: self,
            action: #selector(resignFirstResponder)
        )
        
        let spaceInToolBar = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.setItems([spaceInToolBar, doneButton], animated: false)
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789,.")
        let typedCharacter = CharacterSet(charactersIn: string)
        let isAllowedCharacter = typedCharacter.isSubset(of: allowedCharacterSet)
        
        if !isAllowedCharacter {
            showAlert(withTitle: "Ошибка !", andMessage: "Вводить только цифры") {
                self.setValue(for: textField)
                textField.becomeFirstResponder()
            }
            return false
        }
        
        if string == "," {
            textField.text = (textField.text ?? "") + "."
            return false
        }
        
        return true
    }
}

private extension CGFloat {
    func float() -> Float{
        Float(self)
    }
}
