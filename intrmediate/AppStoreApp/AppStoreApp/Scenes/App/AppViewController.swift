//
//  AppViewController.swift
//  AppStoreApp
//
//  Created by 김성준 on 2022/05/17.
//

import SnapKit
import UIKit

final class AppViewController: UIViewController{
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0 // 간격 0.0을 지정하면 stackView의 subview 높이에 따라 StackView의 높이가 결정됨.
       
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeautreSection = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = UIView()
        
        
        exchangeCodeButtonView.backgroundColor = .green
        
        [featureSectionView,
         rankingFeautreSection,
         exchangeCodeButtonView
        ].forEach{
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
}

private extension AppViewController{
    func setupNavigationController(){
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview() // superView는 TabBarController에서 설정한 NaivationController
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview() // superView -> scrollView
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
