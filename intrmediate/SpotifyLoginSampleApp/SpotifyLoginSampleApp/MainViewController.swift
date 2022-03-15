//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 김성준 on 2022/03/13.
//

import UIKit
import FirebaseAuth
class MainViewController: UIViewController{
    @IBOutlet weak var welcomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomLabel.text = """
                            환영합니다.
                            \(email)님
                           """
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
