//
//  MainViewController.swift
//  RectangleRGB
//
//  Created by Denis Denisov on 20/2/24.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as? SettingViewController
        settingVC?.delegate = self
    }
    
}

extension MainViewController: SettingViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
}