//
//  fetchCountry.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 23/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class fetchCountry {
    
    var url_string = "https://eber.elluminatiinc.com/country_list/"
    var myresponse : JSON = nil
    
    var countriess = NSMutableArray()
    
    var countries : [Country] = []
    
    func fetchCountryList()->NSMutableArray{
        
        Alamofire.request(url_string).responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                for i in 0..<swiftyJsonVar["country"].count {
                    
                    print(Country(countryData: swiftyJsonVar["country"][i]))
                    let countrynames = Country(countryData: swiftyJsonVar["country"][i])
                    self.countries.append(countrynames)
                }
                self.countriess.addObjects(from: self.countries)
                
                print(self.countriess)
          
            }
            
        }
        return countriess
    }

}
