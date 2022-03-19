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
    @IBOutlet weak var resetPasswordButton: UIButton!
    
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
        
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
        
        
    }
    
    @IBAction func restPasswordButtonTapeed(_ sender: UIButton) {
        //사용자의 이메일로 비밀번호 리셋 이메일을 전송.
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email,completion: nil)
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError{
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
    }
}
