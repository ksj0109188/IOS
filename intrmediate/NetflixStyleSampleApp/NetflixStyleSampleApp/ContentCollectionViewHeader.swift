//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by 김성준 on 2022/04/03.
//

import UIKit
// UICollectionReusableView 클래스를 상속 받아야 ColectionView의 Header, Footer가 될 수 있다.
class ContentCollectionViewHeader : UICollectionReusableView{
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17,weight:.bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        })
    }
}
    
