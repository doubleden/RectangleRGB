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
    
    // MARK: - Public Properties
    var color: UIColor!
    weak var delegate: SettingViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
        rectangleView.backgroundColor = color
        updateSlidersValue()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: UISlider) {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        updateValueLabel(sender)
    }

    @IBAction func doneButtonAction() {
        delegate?.setBackgroundColor(rectangleView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}


// MARK: - Enum: Slider Type
extension SettingViewController {
    enum SliderType: Int {
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
        if let sliderType = SliderType(rawValue: slider.tag) {
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
    
    func updateSlidersValue() {
        let colorComponents = getRGBComponents(color)
        
        redSlider.value = colorComponents.red.float()
        greenSlider.value = colorComponents.green.float()
        blueSlider.value = colorComponents.blue.float()
        
        [redSlider, greenSlider, blueSlider].forEach {
            updateValueLabel($0)
        }
    }
}

private extension CGFloat {
    func float() -> Float{
        Float(self)
    }
}
