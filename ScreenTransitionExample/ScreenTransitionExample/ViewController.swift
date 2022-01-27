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

