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
    //날짜 설정(datePicker와 그 값을 저장하는 Date객체 생성)
    private let datePicker = UIDatePicker()
    private var diaryDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurConteentsTextView()
        self.configureDatePicker()
    }
    
    @IBAction func tabConfirmButton(_ sender: UIBarButtonItem) {
    }
    
    //textView border setting
    private func configurConteentsTextView(){
        //255나눈 이유는 red, green, blue parameter에 0~1.0사이에 값이 와야한다
        //따라서 IOS에선 설정하려는 값/255를 해야함.
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        //borderColor를 설정할 땐 UIColor.cgColor property를 사용
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker(){
        //날짜만 설정할 수 있는 모드
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        //UI컨트롤러 객체가 이벤트의 응답하는 방식을 설정하는 메서드(target:이벤트를 처리할 객체, 현재 컨트롤러에서 처리할 것이니 self | action: 이벤트 발생시 호출될 메서드 |for parameter에는 어떤 이벤트가 발생할때 호출될 것인지 설정
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        //dateTextfield를 선택했을대 키보드가 아닌 dateePciker가 나타남
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker : UIDatePicker){
        //데이트 포맷 선언
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM 월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
    }
}
