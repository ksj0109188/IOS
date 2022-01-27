//
//  codePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/27.
//

import UIKit

class codePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
