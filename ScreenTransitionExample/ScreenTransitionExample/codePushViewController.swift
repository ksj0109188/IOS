//
//  codePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/27.
//

import UIKit

class codePushViewController: UIViewController {
    
    @IBOutlet weak var FrameLabel: UILabel!
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.FrameLabel.text = name
            self.FrameLabel.sizeToFit()
        }
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
