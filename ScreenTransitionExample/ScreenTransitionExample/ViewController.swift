//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController 뷰가 로드 되었습니다.")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController뷰가 나타날 것이다..")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewController 뷰가 사라질 것이다.")
    }
    
    override  func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라졌다.")
    }


    @IBAction func tapCodePushButton(_ sender: UIButton) {
        //storyBoard에 있는 viewController를 인스턴스화 하기
        //instantiateViewControoler메소드가 해당 메소드로 설정된 viewcontrollerId를 찾아 인스턴스화 한다.
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "codePushViewController") else { return}
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func tabCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "codePresentViewController") else{ return}
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
      //전체화면 표시하기
        
    }
    
}

