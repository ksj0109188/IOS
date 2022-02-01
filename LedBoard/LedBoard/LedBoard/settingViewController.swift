//
//  settingViewController.swift
//  LedBoard
//
//  Created by 김성준 on 2022/02/01.
//

import UIKit
protocol LedBoardSettingDelegate : AnyObject{
    func changedSetting(text:String?, textColor:UIColor, backgroundColor:UIColor)
}
class settingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orrangeButton: UIButton!
    
    weak var delegate : LedBoardSettingDelegate?
    var ledText : String?
    var textColor : UIColor = .yellow
    var backGroundColor : UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.yellowButton{
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        }else if sender == self.purpleButton{
            self.changeTextColor(color: .purple)
            self.textColor = .purple
        }else if sender == self.greenButton{
            self.changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        if sender == self.blackButton{
            self.changeBackground(color: .black)
            self.backGroundColor = .black
        }else if sender == self.blueButton{
            self.changeBackground(color: .blue)
            self.backGroundColor = .blue
        }else{
            self.changeBackground(color: .orange)
            self.backGroundColor = .orange
        }
    }
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.changedSetting(text: self.textField.text, textColor: self.textColor, backgroundColor: self.backGroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color:UIColor){
        self.yellowButton.alpha = color == UIColor.yellow ? 1: 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1: 0.2
        self.greenButton.alpha = color == UIColor.green ? 1: 0.2
    }
    
    private func changeBackground(color:UIColor){
        self.blackButton.alpha = color == UIColor.black ? 1:0.2
        self.blueButton.alpha = color == UIColor.blue ? 1:0.2
        self.orrangeButton.alpha = color == UIColor.orange ? 1:0.2
    }
    
    //설정초기화 방지
    private func configureView(){
        if let ledText = self.ledText {
            self.textField.text = ledText
            self.changeTextColor(color: self.textColor)
            self.changeBackground(color: self.backGroundColor)
        }
    }
}
