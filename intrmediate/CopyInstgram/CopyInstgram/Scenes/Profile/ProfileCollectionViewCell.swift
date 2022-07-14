//
//  ProfileCollectionViewCell.swift
//  CopyInstgram
//
//  Created by 김성준 on 2022/07/15.
//

import SnapKit
import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell{
 
    private let imageView = UIImageView()
    
    func setup(with image:UIImage){
        addSubview(imageView)
        imageView.snp.makeConstraints{$0.edges.equalToSuperview()}
        imageView.backgroundColor = .tertiaryLabel
    }
}
