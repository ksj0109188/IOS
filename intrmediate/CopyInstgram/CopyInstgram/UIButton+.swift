//
//  UIButton+.swift
//  CopyInstgram
//
//  Created by 김성준 on 2022/07/13.
//

import UIKit
extension UIButton {
    func setImage(systemName: String){ //이미지 사이즈 조절 메소드
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
