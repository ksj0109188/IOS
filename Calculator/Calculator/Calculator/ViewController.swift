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
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        //if and 조건(if 조건문1, 조건문2)
        if self.displayNumber.count < 8, !self.displayNumber.contains("."){
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = displayNumber
        }
    }
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.subtract)
    }
    
    @IBAction func tapPlusButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation){
        if self.currentOperation != .unknown{
            if !self.displayNumber.isEmpty{
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondOperand) else {return}
                switch self.currentOperation{
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .multiply:
                    self.result = "\(firstOperand * secondOperand)"
                case .divide:
                    self.result = "\(firstOperand / secondOperand)"
                default:
                    break
                }
                //truncatingRemainder(dividingBy : 나눌수) -> return 나머지
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0{
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation
        }  else {
            self.firstOperand = displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

