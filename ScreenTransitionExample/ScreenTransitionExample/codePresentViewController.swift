//
//  codePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/27.
//

import UIKit

class codePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
