//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 김성준 on 2022/02/10.
//

import UIKit

enum DiaryEditMode{
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate : AnyObject{
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    
    private let datePicker = UIDatePicker()
    private var diaryDate:Date?
    weak var delegate : WriteDiaryViewDelegate?
    
    var diaryEditorMode: DiaryEditMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurConteentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditMode()
        self.confirmButton.isEnabled = false
        
    }
    
    @IBAction func tabConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.delegate?.didSelectRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
        
        switch self.diaryEditorMode{
        case .new :
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(indexPath, _):
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"), object: diary , userInfo: [
                "indexPath.row" : indexPath.row
            ]
            )
        }
    }
    
    //edit diary
    private func configureEditMode(){
        switch self.diaryEditorMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date:diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
        break
        }
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
    //datePciker, 키보드 선택후 빈 화면을 터치시 datePicker, 키보드 닫기
    //user가 화면을 터치하면 발생하는 이벤트 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        //등록 버튼을 활성화 하기 위해 DatePciker를 통해 값이 들어와도 TextField에 editting 액션이 발생하기 함으로써 유효성 검사 메소드(dateTextFieldDidChange)를 호출하게 한다.
    }
    
    private func configureInputField(){
        //여기서 왜 delegate 객체를 사용하는지 모르겠음.
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(TitleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func TitleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ dateTextField:UITextField){
        self.validateInputField()
    }
    
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
    
    @objc private func datePickerValueDidChange(_ datePicker : UIDatePicker){
        //데이트 포맷 선언
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM 월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    private func dateToString(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    //텍스트 뷰에 텍스트가 입력 될때마다 호출되는 메서드
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
