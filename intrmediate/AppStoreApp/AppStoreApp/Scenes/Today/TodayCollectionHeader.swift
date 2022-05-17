//
//  TodayCollectionHeader.swift
//  AppStoreApp
//
//  Created by 김성준 on 2022/05/16.
//

import SnapKit
import UIKit
import SwiftUI

// Header, Footer가 되기 위해선 ResuableView 상속해야함
final class TodayCollectionHeaderView: UICollectionReusableView{
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "6월 28일 월요일"
        label.font = .systemFont(ofSize: 14.0, weight : .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight:.black)
        label.textColor = .label
        
        return label
    }()
    
    func setupViews(){
        [dateLabel, titleLabel].forEach{addSubview($0)}
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32.0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.left.equalTo(dateLabel)
//            $0.top.equalTo(dateLabel).offset(8.0) //bottom기준이 아님
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.0) //bottom기준
        }
    }
}
