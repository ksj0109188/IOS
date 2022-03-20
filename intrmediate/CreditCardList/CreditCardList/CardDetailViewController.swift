//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 김성준 on 2022/03/20.
//

import UIKit
import Lottie
class CardDetailViewController:UIViewController{
    var promotionDetail : PromotionDetail?
    
    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationVeiw = AnimationView(name: "money")
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationVeiw)
        animationVeiw.frame = lottieView.bounds
        animationVeiw.loopMode = .loop
        animationVeiw.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        
        titleLabel.text = """
                          \(detail.companyName)카드 쓰면
                          \(detail.amount)만원 드립니다.
                          """
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitConditionLabel.text = detail.benefitCondition
        benefitDetailLabel.text = detail.benefitdetail
        benefitDateLabel.text = detail.benefitDate
        
    }
}
