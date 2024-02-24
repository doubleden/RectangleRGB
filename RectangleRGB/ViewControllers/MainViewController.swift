//
//  MainViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 20/2/24.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    var color: UIColor { get }
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as? SettingViewController
        settingVC?.delegate = self
    }
}

// MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    var color: UIColor {
        view.backgroundColor ?? .black
    }
    
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
