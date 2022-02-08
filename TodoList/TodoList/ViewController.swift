//
//  ViewController.swift
//  TodoList
//
//  Created by 김성준 on 2022/02/05.
//

import UIKit

class ViewController: UIViewController {
    var doneButton : UIBarButtonItem?
    var tasks = [Task](){
        //tasks가 호출될때마다 옵저버를 통해 userdefault에서 데이터 저장
        didSet{
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.dataSource = self
        self.loadTasks()
        self.TableView.delegate = self
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        //#selector(버튼을 선택했을때 호출되는 메소드)
    }
    
    //@objc -> swift에서 정의한 메소드를 object-c에서도 호환이 가능하게 하는 attribute
    @objc func doneButtonTap(){
        self.navigationItem.leftBarButtonItem = self.editButton
        self.TableView.setEditing(false, animated: true)
    }

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var TableView: UITableView!
    
    //weak로 설정하면 edit을 눌렀을때 아이템(버튼)이 없어짐.
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        guard !self.tasks.isEmpty else {return}
        self.navigationItem.leftBarButtonItem = self.doneButton
        //편집모드 전환
        self.TableView.setEditing(true, animated: true)
        
        
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        //alert 설정하기
        //1. alertController 생성
        let alert = UIAlertController(title: "할 일을 등록", message: nil, preferredStyle: .alert)
        /*
         alert창에서 Button 추가
         UIAlertAction 메서드 내 Hadler는 클로저 함수가 들어가는데, alert창에서 해당 버튼을 누르면 실행하는 함수를 선언하면 된다.
         alert창에서 사용자가 입력한 데이터(할일 내용) 가지고오기
         hadler 부분에서 task 구조체 인스턴스의 property를 접근하게되면 강한 순환참조가 발생함. -> 메모리 누수 위험이 있어서 closer 선언부에서[weak self] 캡처목록을 정의하면됨 -> 이후 강의에서 설명(
        */
        let registerButton = UIAlertAction(title: "등록", style: .default, handler:  {[weak self]_ in
            guard let title = alert.textFields?[0].text else {return}
            let task = Task(title: title, done: false) // tsak구조체 인스턴스화 하기
            self?.tasks.append(task)
            self?.TableView.reloadData() //테이블 뷰를 갱신
            
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        //alert창에 button 등록
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        //alert창에 textFiled 추가
//        alert.addTextField(configurationHandler: <#T##((UITextField) -> Void)?##((UITextField) -> Void)?##(UITextField) -> Void#> )
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "할 일을 입력해주세요.."})
        
        //UIView Controller present함수를 사용해 alertController를 띄운다.
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveTasks(){
        let data = self.tasks.map{[
            "title" : $0.title,
            "done" : $0.done
        ]
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: "tasks")
}
    
    func loadTasks(){
        let userDefaults = UserDefaults.standard
        guard let data =  userDefaults.object(forKey: "tasks") as? [[String:Any]] else {return}// 데이터 가져오기
                self.tasks = data.compactMap{
                    guard let title = $0["title"] as? String else {return nil}
                    guard let done = $0["done"] as? Bool else {return nil}
                    return Task(title: title, done: done)
                }
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count //섹션의 행 갯수를 리턴하면 , cellForRowAt 파라미터로 행 갯수 전달.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //편집모드에서 삭제기능 구현하기
    //삭제 버튼을 누른 셀이 어떤 셀인지 알려주는 메소드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        //테이블 뷰에도 삭제셀을 전달해 할일 목록 삭제하기
        //swipe 제스처로도 삭제가 가능하게 해줌
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty{
            self.doneButtonTap()
        }
    }
    
    //행의 순서 변경하는 메소드
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //순서가 변경되면, map의 순서도 변경해주어야 한다. -> 그 상태로 유지되면, 행의 위치를 변경한 이유가 없어짐
        var tasks = self.tasks
        //배열의 특성상 삭제된 인덱스는 앞당겨 진다 -> ex) 0, 1, 2 일 경우 1이 삭제된다면, 삭제되기전 2번째 인덱스가 삭제후 1번째 인덱스로 되는 메커니즘을 생각해 아래 코드를 생각하면 이해가 된다.
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
}

extension ViewController:UITableViewDelegate{
    //cell을 선택했을때 어떤 셀이 선택되었는지 알려주는 기능
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row] //첫 번째 셀일경우 indexPath.row는 1, 그 다음은 2 3 4 가 될 것이다.
        task.done = !task.done
        self.tasks[indexPath.row] = task
        //체크된 셀의 row만 reload하는 메소드 [at:리로드할 셀(전체도 가능한데 현재 어플리케이션은 한 행만 리로드), with: 열거형 에니메이션 파라미터]
        self.TableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
