//
//  codePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/27.
//

import UIKit
protocol sendDataDelegate : AnyObject{
    func sendData(name:String)
}
class codePresentViewController: UIViewController {

    @IBOutlet weak var FrameLabel: UILabel!
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.FrameLabel.text = name
            self.FrameLabel.sizeToFit()
        }
    }
    weak var delegate : sendDataDelegate?
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Gunter")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
