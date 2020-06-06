//
//  EOBaseTabBarController.swift
//  Eduoep
//
//  Created by apple on 2020/6/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOBaseTabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        createTabBarItem()
        
        // Do any additional setup after loading the view.
    }
    
    func createTabBarItem() {
        let homeVC = HomeViewController()
        let meVC = MeViewController()
        let studyVC = StudyViewController()
        homeVC.tabBarItem = ESTabBarItem.init(title: "Home", image: UIImage(named: "tab_home"), selectedImage: UIImage(named: "tab_home_select"))
     
        studyVC.tabBarItem = ESTabBarItem.init(title: "Study", image: UIImage(named: "tab_study"), selectedImage: UIImage(named: "tab_study_select"))
        meVC.tabBarItem = ESTabBarItem.init(title: "Find", image: UIImage(named: "tab_me"), selectedImage: UIImage(named: "tab_me_select"))
        self.viewControllers = [homeVC,studyVC,meVC]
        
    }

}
