//
//  ViewController.swift
//  Calculator
//
//  Created by 김성준 on 2022/02/02.
//

import UIKit

enum Operation {
    case Add
    case subtract
    case divide
    case multiply
    case unknown
}
class ViewController: UIViewController {

    
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation : Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapNumberButton(_ sender: UIButton) {
//        guard let numberValue = sender.title(for: .normal) else {return} 에러난 코드, sender.Title이 nil 값을 가짐 해결책으로 아래 코드 사용.
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = displayNumber
        }
        
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
    }
    @IBAction func tapDotButton(_ sender: UIButton) {
    }
    @IBAction func tapDivideButton(_ sender: UIButton) {
    }
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
    }
    @IBAction func tapSubtractButton(_ sender: UIButton) {
    }
    @IBAction func tapPlusButton(_ sender: UIButton) {
    }
    @IBAction func tapEqualButton(_ sender: UIButton) {
    }
}

