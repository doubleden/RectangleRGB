//
//  ViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 2/2/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var rectangleView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    private var currentRedValueColor = 0.33
    private var currentGreenValueColor = 0.65
    private var currentBlueValueColor = 0.22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
        updateReactangleColor()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            currentRedValueColor = Double(sender.value)
            changeValue(in: redValueLabel, sender)
        case greenSlider:
            currentGreenValueColor = Double(sender.value)
            changeValue(in: greenValueLabel, sender)
        case blueSlider:
            currentBlueValueColor = Double(sender.value)
            changeValue(in: blueValueLabel, sender)
        default:
            return
        }
        updateReactangleColor()
    }
    
    private func updateReactangleColor() {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(currentRedValueColor),
            green: CGFloat(currentGreenValueColor),
            blue: CGFloat(currentBlueValueColor),
            alpha: 1
        )
    }
    
    private func changeValue(in value: UILabel, _ slider: UISlider) {
        value.text = slider.value.formatted(
            .number.precision(
                .fractionLength(2)
            )
        )
    }
}
