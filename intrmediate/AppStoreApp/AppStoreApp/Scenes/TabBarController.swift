//
//  TabBarController.swift
//  AppStoreApp
//
//  Created by 김성준 on 2022/05/10.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "mail"), tag: 0)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up"), tag: 1)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        viewControllers = [todayViewController,appViewController]
    }


}

