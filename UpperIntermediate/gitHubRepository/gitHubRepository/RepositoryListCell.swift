//
//  RepositoryListCell.swift
//  gitHubRepository
//
//  Created by 김성준 on 2022/07/24.
//

import UIKit
import SnapKit

class RepositroyListCell: UITableViewCell{
    var repository: Repsitory?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languagelabel = UILabel()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [
            nameLabel, descriptionLabel,
            starImageView, starLabel, languagelabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        guard let repository = repository else {return }
        nameLabel.text = repository.name
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        descriptionLabel.text = repository.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 2
        
        starImageView.image = UIImage(systemName: "star")
        
        starLabel.text = "\(repository.stargazersCount)"
        starLabel.font = .systemFont(ofSize: 16)
        starLabel.textColor = .gray
        
        languagelabel.text = repository.language
        languagelabel.font = .systemFont(ofSize: 16)
        languagelabel.textColor = .gray
        
        nameLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLabel)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        starLabel.snp.makeConstraints{
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languagelabel.snp.makeConstraints{
            $0.centerY.equalTo(starLabel)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
    }
}
