//
//  StationDetailCollectionViewCell.swift
//  SubwatStation
//
//  Created by 김성준 on 2022/06/26.
//

import Foundation
import UIKit
import SwiftUI

final class StationDetailCollectionViewCell : UICollectionViewCell {
    
    
    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight : .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    func setup(with realTimeArrival: StationArrivalDataResponseModel.RealTimeArrival){
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        backgroundColor = .systemBackground
        
        [lineLabel, remainTimeLabel].forEach{addSubview($0)}
        
        lineLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        remainTimeLabel.snp.makeConstraints{
            $0.leading.equalTo(lineLabel)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
        
        lineLabel.text = realTimeArrival.line
        remainTimeLabel.text = realTimeArrival.remainTime
    }
}
