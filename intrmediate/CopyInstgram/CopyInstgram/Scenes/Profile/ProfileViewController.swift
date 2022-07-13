//
//  ProfileViewController.swift
//  CopyInstgram
//
//  Created by 김성준 on 2022/07/14.
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
}
private extension ProfileViewController{
    func setupNavigationItems(){
        navigationItem.title = "UserName"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
}

