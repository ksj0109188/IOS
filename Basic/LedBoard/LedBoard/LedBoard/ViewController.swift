//
//  ViewController.swift
//  LedBoard
//
//  Created by 김성준 on 2022/02/01.
//

import UIKit

class ViewController: UIViewController, LedBoardSettingDelegate{
    
    
    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentLabel.textColor = .yellow
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as?  settingViewController{
            print("check prepare")
            settingViewController.delegate = self
            settingViewController.ledText = self.contentLabel.text
            settingViewController.textColor = self.contentLabel.textColor
            //옵셔널일 경우 black으로 값 지정
            settingViewController.backGroundColor = self.view.backgroundColor ?? .black
        }
    }
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentLabel.text = text
        }
        self.contentLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}

