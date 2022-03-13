//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 김성준 on 2022/03/13.
//

import UIKit

class LoginViewController:UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //firebase인증
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //firebase인증
    }
}
