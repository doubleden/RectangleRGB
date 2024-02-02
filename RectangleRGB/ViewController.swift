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
    
    private var currentRedLabelValue = 0.33
    private var currentGreenLabelValue = 0.65
    private var currentBlueLabelValue = 0.22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
        rectangleView.backgroundColor = UIColor(
            red: currentRedLabelValue,
            green: currentGreenLabelValue,
            blue: currentBlueLabelValue,
            alpha: 1
        )
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            currentRedLabelValue = Double(sender.value)
            changeValue(in: redValueLabel, sender)
            changeReactangleColor()
        case greenSlider:
            currentGreenLabelValue = Double(sender.value)
            changeValue(in: redValueLabel, sender)
            changeReactangleColor()
        case blueSlider:
            currentBlueLabelValue = Double(sender.value)
            changeValue(in: redValueLabel, sender)
            changeReactangleColor()
        default:
            return
        }
    }
    
    private func changeReactangleColor() {
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(currentRedLabelValue),
            green: CGFloat(currentGreenLabelValue),
            blue: CGFloat(currentBlueLabelValue),
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
