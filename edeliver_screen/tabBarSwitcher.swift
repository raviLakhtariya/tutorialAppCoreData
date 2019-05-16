//
//  tabBarSwitcher.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 16/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import UIKit
 @objc protocol TabBarSwitcher {
    func handleSwipes(_ sender:UISwipeGestureRecognizer)
}

extension TabBarSwitcher where Self: UIViewController {
    func initSwipe( _ direction:         UISwipeGestureRecognizerDirection){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(TabBarSwitcher.handleSwipes(_:))) /*#selector(TabBarSwitcher.handleSwipes(_:)))*/
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
    }
}
