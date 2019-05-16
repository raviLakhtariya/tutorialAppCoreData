//
//  custometabViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 16/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class custometabViewController: UITabBarController,UINavigationControllerDelegate,UINavigationBarDelegate,UITabBarControllerDelegate,TabBarSwitcher {

    
    @IBInspectable var indicatorColor: UIColor = UIColor()
    
    @IBInspectable var onTopIndicator: Bool = true
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    var divide : Int = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width , height: tabBar.frame.size.height + 20)
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        tabBar.layer.shadowRadius = 2;
        tabBar.layer.shadowColor = UIColor .black.cgColor;
        tabBar.layer.shadowOpacity = 0.5;
        self.tabBar.itemPositioning = UITabBarItemPositioning.fill

        self.tabBarController?.delegate = self
   
        
        let fontsize = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.systemFont(ofSize: 19.0),]
        UITabBarItem.appearance().setTitleTextAttributes(fontsize, for: .normal)
        
        
        
        
        
        
    }
    
    
    func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left{
            tabBarController?.selectedIndex = 1
            let loginScreen = self.storyboard?.instantiateViewController(withIdentifier: "login")as! LoginViewController
            initSwipe(.right)
            
            self.present(loginScreen, animated: true, completion: nil)

         
            
        }
        if (sender.direction == .right) {
          
            tabBarController?.selectedIndex = 0
            let registerScreen = self.storyboard?.instantiateViewController(withIdentifier: "login")as! RegisterViewController
            initSwipe(.left)
            self.present(registerScreen, animated: true, completion: nil)
        
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if selectedViewController == nil || viewController == selectedViewController {
            return false
        }
        
        let fromView = selectedViewController!.view
        let toView = viewController.view
        
        UIView.transition(from: fromView!, to: toView!, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        
        return true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    override func viewWillLayoutSubviews() {
        

        super.viewWillLayoutSubviews()
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.shadowOffset = CGSize.init(width: 0, height: 5)
               tabBar.layer.shadowRadius = 2;
                tabBar.layer.shadowColor = UIColor .black.cgColor;
               tabBar.layer.shadowOpacity = 0.5;
        self.tabBar.itemPositioning = UITabBarItemPositioning.fill
   
        let fontsize = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.systemFont(ofSize: 19.0),]
        UITabBarItem.appearance().setTitleTextAttributes(fontsize, for: .normal)
    
        guard let numberOfTabs = tabBar.items?.count else {
            return
        }
       
     
 

     
        
        
        
        
        
        
        
        
        let numberOfTabsFloat = CGFloat(numberOfTabs)
        let imageSize = CGSize(width: tabBar.frame.width / numberOfTabsFloat,
                               height: tabBar.frame.height)
        
        
        let indicatorImage = UIImage.drawTabBarIndicator(color: indicatorColor,
                                                         size: imageSize,
                                                         onTop: onTopIndicator)
        self.tabBar.selectionIndicatorImage = indicatorImage


    
    
    
    
    }
    

    
}
extension UIImage{
    //Draws the top indicator by making image with filling color
    class func drawTabBarIndicator(color: UIColor, size: CGSize, onTop: Bool) -> UIImage {
        let indicatorHeight = size.height / 20
        let yPosition = onTop ? 0 : (size.height - indicatorHeight)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: yPosition, width: size.width, height: indicatorHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
