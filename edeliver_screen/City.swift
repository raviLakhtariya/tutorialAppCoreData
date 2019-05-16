//
//  City.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 23/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class  City {
    
    var citycode = String()
    var cityname = String()
  
    
    init(cityData:JSON) {
        self.citycode = cityData["citycode"].stringValue
        self.cityname = cityData["cityname"].stringValue
                print(self.cityname)
    }
}
