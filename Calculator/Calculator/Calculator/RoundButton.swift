//
//  RoundButton.swift
//  Calculator
//
//  Created by 김성준 on 2022/02/02.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
     @IBInspectable var isRound: Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
