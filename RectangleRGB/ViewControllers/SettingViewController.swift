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

// MARK: - Enum
private extension SettingViewController {
    enum Color: Int {
        case red = 1
        case green = 2
        case blue = 3
    }
}

// MARK: - Private Methods
private extension SettingViewController {
    
    func getRGBComponents(_ color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue)
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
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
        if let sliderType = Color(rawValue: slider.tag) {
            switch sliderType {
            case .red:
                redValueLabel.text = string(from: slider)
                redValueTF.text = string(from: slider)
            case .green:
                greenValueLabel.text = string(from: slider)
                greenValueTF.text = string(from: slider)
            case .blue:
                blueValueLabel.text = string(from: slider)
                blueValueTF.text = string(from: slider)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if isInputCorrect(in: textField) {
            if let textFieldType = Color(rawValue: textField.tag) {
                let numberTF = Float(textField.text?.replacingOccurrences(of: ",", with: ".") ?? "")
                
                switch textFieldType {
                case .red:
                    redSlider.value = numberTF ?? 0
                    updateValue(for: redSlider)
                case .green:
                    greenSlider.value = numberTF ?? 0
                    updateValue(for: greenSlider)
                case .blue:
                    blueSlider.value = numberTF ?? 0
                    updateValue(for: blueSlider)
                }
                updateRectangleColor()
            }
        }

    }
    
    func isInputCorrect(in textField: UITextField) -> Bool {
        if textField.text == "" {
            setupValue(in: textField)
            return false
        } else if !isValid(input: textField.text ?? "") {
            showAlert(
                withTitle: "Числа можно задавать только от 0 до 1",
                andMessage: "Или не больше двух цифр после запятой") {
                    self.setupValue(in: textField)
                }
            return false
        }
        return true
    }
    
    func setupValue(in textField: UITextField) {
        if let sliderType = Color(rawValue: textField.tag){
            switch sliderType {
            case .red:
                textField.text = redValueLabel.text
            case .green:
                textField.text = greenValueLabel.text
            case .blue:
                textField.text = blueValueLabel.text
            }
        }
    }
}

private extension CGFloat {
    func float() -> Float{
        Float(self)
    }
}
