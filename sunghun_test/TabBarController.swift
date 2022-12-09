//
//  TabBarController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let componentVC = UINavigationController(rootViewController: ComponentController())
        componentVC.tabBarItem.selectedImage = UIImage(systemName: "square.fill")
        componentVC.tabBarItem.title = "컴포넌트"
        componentVC.tabBarItem.image = UIImage(systemName: "square")
        
        let componentVC2 = UINavigationController(rootViewController: Component2Controller())
        componentVC2.tabBarItem.selectedImage = UIImage(systemName: "square.fill")
        componentVC2.tabBarItem.title = "컴포넌트2"
        componentVC2.tabBarItem.image = UIImage(systemName: "square")
        
        let mapVC = UINavigationController(rootViewController: MapViewController())
        mapVC.tabBarItem.selectedImage = UIImage(systemName: "square.fill")
        mapVC.tabBarItem.title = "맵"
        mapVC.tabBarItem.image = UIImage(systemName: "square")
        
        let tableVC = UINavigationController(rootViewController: TableViewController())
        tableVC.tabBarItem.selectedImage = UIImage(systemName: "square.fill")
        tableVC.tabBarItem.title = "테이블"
        tableVC.tabBarItem.image = UIImage(systemName: "square")
        
        viewControllers = [componentVC, componentVC2, mapVC, tableVC]
    }
}
