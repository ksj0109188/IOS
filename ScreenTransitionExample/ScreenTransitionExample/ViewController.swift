//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by 김성준 on 2022/01/26.
//

import UIKit

class ViewController: UIViewController, sendDataDelegate {
    

    @IBOutlet weak var nameLabel: UILabel!
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
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "codePushViewController") as? codePushViewController else { return}
        viewController.name = "Gunter"
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func tabCodePresentButton(_ sender: UIButton) {
        //각각의 controller view를 다운캐스팅을 통해 하위 요소(label, button 등등)을 접근할 수 있다.
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "codePresentViewController") as? codePresentViewController else{ return}
        viewController.name = "Gunter"
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
      //전체화면 표시하기
        
    }
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
    //preare메소드를(전처리 메서드)오버라이드 하기 되면 segueway를 호춣하기 직전에 시스템에 의해 오버라이드된 prepare메소드가 자동으로 실행하게 된다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destination을 되면 전환하려는 인스턴스를 가지고 오게 된다.
        //다운캐스팅을 통해 특정컨트롤러이면(as?구문) name에 Gunter값을 초기화하는 코드이다
        if let viewController = segue.destination as? SeguePushViewController{
            viewController.name = "Gunter"
        }
    }
}

