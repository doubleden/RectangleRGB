//
//  ViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 2/2/24.
//

import UIKit

final class SettingViewController: UIViewController {
    
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
    weak var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        view.endEditing(true)
        updateValue(for: sender)
        updateRectangleColor()
    }

    @IBAction func doneButtonAction() {
        delegate?.setBackgroundColor(rectangleView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

private extension SettingViewController {
    // MARK: - Setup Methods
    func setupUI() {
        rectangleView.layer.cornerRadius = 10
        setupKeyBoard()
        setupSlidersValue()
        updateRectangleColor()
    }
    
    func setupSlidersValue() {
        let colorComponents = getRGBComponents(color)
        
        redSlider.value = colorComponents.red.float()
        greenSlider.value = colorComponents.green.float()
        blueSlider.value = colorComponents.blue.float()
        
        [redSlider, greenSlider, blueSlider].forEach { updateValue(for: $0) }
    }
    
    func setupKeyBoard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "done",
            style: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )
        
        let spaceInToolBar = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        toolbar.setItems([spaceInToolBar, doneButton], animated: false)
        [redValueTF, greenValueTF, blueValueTF].forEach { $0.inputAccessoryView = toolbar }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Update Methods
    func updateRectangleColor() {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func updateValue(for slider: UISlider) {
        switch slider {
        case redSlider:
            redValueLabel.text = string(from: slider)
            redValueTF.text = string(from: slider)
        case greenSlider:
            greenValueLabel.text = string(from: slider)
            greenValueTF.text = string(from: slider)
        default:
            blueValueLabel.text = string(from: slider)
            blueValueTF.text = string(from: slider)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isInputCorrect(in: textField) {
            let numberTF = Float(textField.text?.replacingOccurrences(of: ",", with: ".") ?? "")
            switch textField {
            case redValueTF:
                redSlider.value = numberTF ?? 0
                updateValue(for: redSlider)
            case greenValueTF:
                greenSlider.value = numberTF ?? 0
                updateValue(for: greenSlider)
            default:
                blueSlider.value = numberTF ?? 0
                updateValue(for: blueSlider)
            }
            updateRectangleColor()
            
        }
    }
    
    func isInputCorrect(in textField: UITextField) -> Bool {
        if textField.text == "" {
            returnValue(in: textField)
            return false
        } else if !isValid(input: textField.text ?? "") {
            showAlert(
                withTitle: "Числа можно задавать только от 0 до 1",
                andMessage: "Или не больше двух цифр после запятой") {
                    self.returnValue(in: textField)
                }
            return false
        }
        return true
    }
    
    func returnValue(in textField: UITextField) {
        switch textField {
        case redSlider:
            textField.text = redValueLabel.text
        case greenSlider:
            textField.text = greenValueLabel.text
        default:
            textField.text = blueValueLabel.text
        }
        
    }
}

private extension CGFloat {
    func float() -> Float{
        Float(self)
    }
}
