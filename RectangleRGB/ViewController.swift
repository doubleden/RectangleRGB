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
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            changeValue(in: redValueLabel, sender)
        case greenSlider:
            changeValue(in: greenValueLabel, sender)
        case blueSlider:
            changeValue(in: blueValueLabel, sender)
        default:
            return
        }
    }
    
    
    private func changeValue(in value: UILabel, _ slider: UISlider) {
        value.text = slider.value.formatted(
            .number.precision(
                .fractionLength(2)
            )
        )
    }
}
