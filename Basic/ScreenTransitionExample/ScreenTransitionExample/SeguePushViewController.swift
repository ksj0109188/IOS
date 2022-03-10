//
//  SeguePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/26.
//

import UIKit

class SeguePushViewController: UIViewController {
    var name : String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("SeguePush 뷰가 로드 되었습니다.")
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SeguePush뷰가 나타날 것이다..")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SeguePush뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SeguePush 뷰가 사라질 것이다.")
    }
    
    override  func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SeguePush 뷰가 사라졌다.")
    }

    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popToRootViewController(animated: true) // 최상위 루트 컨트롤러뷰로 이동
    }
}
