//
//  FeedViewController.swift
//  CopyInstgram
//
//  Created by 김성준 on 2022/07/06.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviagationBar()
    }
    

}

private extension FeedViewController {
    func setupNaviagationBar() {
        
        navigationItem.title = "CopyInstagram"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItem = uploadButton
    }
}
