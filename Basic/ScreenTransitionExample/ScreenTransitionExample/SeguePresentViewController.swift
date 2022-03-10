//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/27.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func tabBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
