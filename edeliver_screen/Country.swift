//
//  Country.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 21/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import SwiftyJSON


class  Country {
  
    var _id = String()
    var countryname = String()
    var flag_url = String()
    var countryphonecode = String()
    var phone_number_length = Int()
    var phone_number_min_length = Int()
    
    init(countryData:JSON) {
        self._id = countryData["_id"].stringValue
        self.countryname = countryData["countryname"].stringValue
                self.flag_url = countryData["flag_url "].stringValue
                self.countryphonecode = countryData["countryphonecode"].stringValue
                self.phone_number_length = countryData["phone_number_length"].intValue
         self.phone_number_min_length = countryData["phone_number_min_length"].intValue
        print(self.countryname)
          print(self.countryphonecode)
    }
    
}
