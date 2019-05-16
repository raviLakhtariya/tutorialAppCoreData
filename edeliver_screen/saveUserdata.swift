//
//  saveUserdata.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 24/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation

class saveUserdata {
        var status : Bool? = false
    var iduser : Int16? = nil
    
    func setdata(email:String,password:String,status:Bool)->Bool{
      var value = false
        let userDefault = UserDefaults.standard
        
        userDefault.set(email, forKey: "email")
        userDefault.set(password, forKey: "password")
        userDefault.set(status, forKey: "status")
      
        print("successfully registerd")
        value = true
        return value
    }
    
    func getData()->(Int16,String,String,Bool){
      
        let userDefault = UserDefaults.standard
         iduser = userDefault.object(forKey: "id") as? Int16
    let email = userDefault.object(forKey: "email")
        let password = userDefault.object(forKey: "password")
         status = userDefault.object(forKey: "status") as? Bool

        
        
        
     
        
        
        print(iduser ?? "id is null")
        print(email ?? "email is null")
        print(password ?? "password is null")
        print(status ?? "status is null" )
        
        return ((iduser ?? 0),email as! String? ?? "email is null" ,password as! String? ?? "email is null",(status ?? false)!)
    }
    
    
    func removeData()->Bool{
        
        var value : Bool = false
        let prefs = UserDefaults.standard
    
        prefs.removeObject(forKey: "id")
        prefs.removeObject(forKey: "email")
        prefs.removeObject(forKey: "password")
        prefs.removeObject(forKey: "status")
        if prefs.object(forKey: "email") == nil && prefs.object(forKey: "password") == nil {
            value = true
        print("successfully remove")
        }
        else{
            print("Error")
            value = false
        }
        return value
    }
}

