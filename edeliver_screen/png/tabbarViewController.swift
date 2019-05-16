//
//  tabbarViewController.swift
//  edelivery
//
//  Created by Elluminati Mac Mini 1 on 16/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class tabbarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
      self.delegate = self
       let tabbar = UITabBar.init(frame: CGRect(x:10, y: 20, width: 375, height: 50))
        self.tabBar.backgroundColor = UIColor.brown
        
      
        let tabOne = LoginViewController()
        let tabOneBarItem = UITabBarItem(title: "Login", image: nil, tag: 0)
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = RegisterViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Register", image: nil, tag: 1)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
      
     //   self.viewControllers = [tabOne, tabTwo]
            self.view.addSubview(tabbar)
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
