//
//  SeguePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/26.
//

import UIKit

class SeguePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popToRootViewController(animated: true) // 최상위 루트 컨트롤러뷰로 이동
    }
}
