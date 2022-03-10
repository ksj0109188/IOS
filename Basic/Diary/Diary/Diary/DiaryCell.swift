//
//  DiaryCell.swift
//  Diary
//
//  Created by 김성준 on 2022/02/10.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //Cell영역에 테두리 그리기
    //UIView가 story보드나 Xid를 통해 객체를 생성하게 될때 이 생성자를 통해 생성하게 된다.
    //이 생성자를 통해 코드상 컴포넌트들이 UIView에 표시될 때 스타일을 지정할 수 있다.
    required init?(coder:NSCoder){
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
