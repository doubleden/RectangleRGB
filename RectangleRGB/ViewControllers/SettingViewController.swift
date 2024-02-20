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
    
    weak var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        
        updateValueLabel(sender)
    }

    
    private func updateValueLabel(_ slider: UISlider) {
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
}

// MARK: Slider Type
extension SettingViewController {
    enum SliderType: Int {
        case red = 1
        case green = 2
        case blue = 3
    }
}