//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 김성준 on 2022/02/10.
//

import UIKit

class WriteDiaryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurConteentsTextView()
    }
    
    @IBAction func tabConfirmButton(_ sender: UIBarButtonItem) {
    }
    
    private func configurConteentsTextView(){
        //255나눈 이유는 red, green, blue parameter에 0~1.0사이에 값이 와야한다
        //따라서 IOS에선 설정하려는 값/255를 해야함.
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        //borderColor를 설정할 땐 UIColor.cgColor property를 사용
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
}
