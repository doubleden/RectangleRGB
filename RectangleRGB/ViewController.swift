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
        rectangleView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        
        switch sender {
        case redSlider:
            redValueLabel.text = String(format: "%.2f", sender.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", sender.value)
        default:
            blueValueLabel.text = String(format: "%.2f", sender.value)
        }
    }
}
