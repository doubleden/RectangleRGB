//
//  Extensions + UIView.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 21/2/24.
//

import UIKit

extension UIViewController {
    
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
    
    func showAlert(
        withTitle title: String,
        andMessage message: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: "OK", style: .default) {_ in 
            completion?()
        }
        
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func isValid(input: String) -> Bool {
        let numberPattern = "^0(,\\d{1,2})?$|1(,0{0,2})?$"
        return NSPredicate(format: "SELF MATCHES %@", numberPattern)
            .evaluate(with: input)
    }
}
