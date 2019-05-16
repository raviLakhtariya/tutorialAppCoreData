//
//  showmap.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 22/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import Foundation
class showmap {
    var stringAddress = String()

    func updateData(address:String){
        self.stringAddress = address
    
    }
    func getdata()->String{
        let string = self.stringAddress
        print(string)
        return string
    }
}
