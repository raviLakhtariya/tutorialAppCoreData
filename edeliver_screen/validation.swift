//
//  validation.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 22/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

class validations {
    var name = String()
    var email = String()
    var password = String()
    var conformPassword = String()
    var selectCountry = String()
    var selectCity = String()
    var Address = String()
    var countryCode = String()
       var mobileno = String()
    var selectStoreType = String()
       var refferal = String()
    

    
    func validationtextField(name:String,email:String,password:String,conformPassword:String,selectCountry:String,selectCity:String,Address:String,countryCode:String,mobileno:String,selectStoreType:String,refferal:Bool)->(String,String,Bool){
        var title = String()
        var message = String()
        var value = Bool()
      
        
        
        
        if name.isEmpty || email.isEmpty || password.isEmpty || conformPassword.isEmpty || selectCountry.isEmpty || selectCity.isEmpty || selectStoreType.isEmpty || mobileno.isEmpty || Address.isEmpty {
    
            title = "Register"
            message = "Inser required field"
            value = false
        
        
        }else{
        
            if password != conformPassword {
                title = "password"
                message = "password does not match"
                value = false
            }
            else {
                if isValidEmail(testStr: email) == false{
                    title = "Email id"
                    message = "Insert correct Email id "
                    value = false
                    
                }else{
                    
                    if (mobileno.characters.count != (countryCode.characters.count + 10) && isValidPhone(value: mobileno) == false ) {
                        title = "mobile no"
                        message = "Insert 10 numbers must"
                        value = false
                    }
                    else{
                        title = "registerd"
                        message = "correct"
                        value = true
                    }

                }
            }


            
        }
        return (title , message , value)
}
    
    func validationtextField1(name:String,email:String,password:String,selectCountry:String,selectCity:String,Address:String,countryCode:String,mobileno:String,selectStoreType:String)->(String,String,Bool){
        var title = String()
        var message = String()
        var value = Bool()
        
        
        
        
        if name.isEmpty || email.isEmpty || password.isEmpty  || selectCountry.isEmpty || selectCity.isEmpty || selectStoreType.isEmpty || mobileno.isEmpty || Address.isEmpty  {
            
            title = "Update"
            message = "Inser required field"
            value = false
            
            
        }else{
            
           
                if isValidEmail(testStr: email) == false{
                    title = "Email id"
                    message = "Insert correct Email id "
                    value = false
                    
                }else{
                    
                    if (mobileno.characters.count != (countryCode.characters.count + 10) && isValidPhone(value: mobileno) == false ) {
                        title = "mobile no"
                        message = "Insert 10 numbers must"
                        value = false
                    }
                    else{
                        title = "update"
                        message = "correct"
                        value = true
                    }
                    
                }
            
            
            
            
        }
        return (title , message , value)
    }

    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with:value)
        return result
    }
    
    
   

}
