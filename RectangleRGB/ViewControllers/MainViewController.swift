//
//  MainViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 20/2/24.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as? SettingViewController
        settingVC?.color = view.backgroundColor
        settingVC?.delegate = self
    }
}

// MARK: - SettingViewControllerDelegate
extension MainViewController: SettingViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
