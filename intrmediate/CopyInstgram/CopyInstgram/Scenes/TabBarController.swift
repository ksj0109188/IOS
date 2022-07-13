//
//  TabBarController.swift
//  CopyInstgram
//
//  Created by 김성준 on 2022/07/07.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        viewControllers = [feedViewController, profileViewController]
    }
    
    
}
