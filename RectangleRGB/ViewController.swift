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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleView.layer.cornerRadius = 10
    }
    
    @IBAction func sliderAction() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)

        rectangleView.backgroundColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
        
        updateValueLabel(redValueLabel, in: redSlider)
        updateValueLabel(greenValueLabel, in: greenSlider)
        updateValueLabel(blueValueLabel, in: blueSlider)
    }
    
    private func updateValueLabel(_ valueLabel: UILabel, in slider: UISlider) {
        valueLabel.text = slider.value.formatted(
            .number.precision(
                .fractionLength(2)
            )
        )
    }
}
