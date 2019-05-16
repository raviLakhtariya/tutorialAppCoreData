//
//  WhiteSpaceC.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 22/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

class WhiteSpaceC {
    
    func containWhiteSpace(text:String)->String {
        var textdata = String()
      
        
        let whitespace = NSCharacterSet.whitespaces
        
        let range = text.rangeOfCharacter(from: whitespace)
        
        // range will be nil if no whitespace is found
        if let test = range {
            
            print("whitespace found")
            
            let endIndex = text.index(text.endIndex, offsetBy: -1)
            textdata = text.substring(to: endIndex)
            
            print("\(text) and \(textdata)")
           // self.selectCountry.rightView?.alpha = 0.0
            
        }
        else {
         //   self.selectCountry.rightView?.alpha = 0.0
            print("whitespace not found")
        }

       
        return text
    }
}
