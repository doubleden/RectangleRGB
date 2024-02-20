//
//  ViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 2/2/24.
//

import UIKit

final class SettingViewController: UIViewController {
    // MARK: - IB Outlets
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
    
    // MARK: - Public Properties
    var color: UIColor!
    weak var delegate: SettingViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyBoard()
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        rectangleView.layer.cornerRadius = 10
        updateSlidersValue()
        updateRectAngleColor()
        updateTextFieldValue()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        updateRectAngleColor()
        updateValueLabel(sender)
    }

    @IBAction func doneButtonAction() {
        view.endEditing(true)
        delegate?.setBackgroundColor(rectangleView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}


// MARK: - Enum: Color
extension SettingViewController {
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
    
    // MARK: - Updatable Methods
    func updateValueLabel(_ slider: UISlider) {
        if let sliderType = Color(rawValue: slider.tag) {
            switch sliderType {
            case .red:
                redValueLabel.text = String(format: "%.2f", slider.value)
            case .green:
                greenValueLabel.text = String(format: "%.2f", slider.value)
            case .blue:
                blueValueLabel.text = String(format: "%.2f", slider.value)
            }
        }
    }
    
    func updateTextFieldValue() {
        redValueTF.text = redSlider.value.formatted()
        greenValueTF.text = greenSlider.value.formatted()
        blueValueTF.text = blueSlider.value.formatted()
    }
    
    func updateSlidersValue() {
        let colorComponents = getRGBComponents(color)
        
        redSlider.value = colorComponents.red.float()
        greenSlider.value = colorComponents.green.float()
        blueSlider.value = colorComponents.blue.float()
        
        [redSlider, greenSlider, blueSlider].forEach {
            updateValueLabel($0)
        }
    }
    
    func updateRectAngleColor() {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func setupKeyBoard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(doneButtonAction))
        let spaceInToolBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceInToolBar, doneButton], animated: false)
        [redValueTF, greenValueTF, blueValueTF].forEach { $0.inputAccessoryView = toolbar }
    }
}

// MARK: - UI TextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        let numberTF = Float(textField.text?.replacingOccurrences(of: ",", with: ".") ?? "")
        switch textField {
        case redValueTF:
            redSlider.value = numberTF ?? 0
            updateValueLabel(redSlider)
            updateRectAngleColor()
        case greenValueTF:
            greenSlider.value = numberTF ?? 0
            updateValueLabel(greenSlider)
            updateRectAngleColor()
        case blueValueTF:
            blueSlider.value = numberTF ?? 0
            updateValueLabel(blueSlider)
            updateRectAngleColor()
        default:
            return
        }
    }
}

private extension CGFloat {
    func float() -> Float{
        Float(self)
    }
}
