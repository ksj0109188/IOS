//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 김성준 on 2022/03/13.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController : UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        //구글 로그인
        GIDSignIn.sharedInstance.signIn(with:config, presenting: self){
            [unowned self] user, error in

              if let error = error {
                  print("Error Google Sign In \(error.localizedDescription)")
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
                    
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){_,_ in
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController(){
        let storybard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storybard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
   
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //Apple Develpoer 등록후 구현예정
    }
    
}
