//
//  signup.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 03/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
class signup {
    
    
    
    func singupmethod(nameStr : String,emailStr:String,passwordStr:String,conformPasswordStr:String,selectCountryStr:String,selectCityStr:String,AddressStr:String,selectStoreTypeStr:String,mobilenosStr:String,status:Bool)->Int16{
        
        
        print(nameStr)
        print(emailStr)
        print(passwordStr)
        print(conformPasswordStr)
        print(selectCountryStr)
        print(selectCityStr)
        print(AddressStr)
        print(selectStoreTypeStr)
        print(mobilenosStr)
        print(status)
        if status == false {
            let student = NSEntityDescription.insertNewObject(forEntityName: "User", into: DataBaseController.persistentContainer.viewContext) as! User
            
            let array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
            
            student.userid = Int16(array[Int(arc4random_uniform(UInt32(array.count)))])
            student.name = nameStr
            student.email = emailStr
            student.password = passwordStr
            student.conformpassword = conformPasswordStr
            student.selectCountry = selectCountryStr
            student.selectCity = selectCityStr
            student.address = AddressStr
            student.link = selectStoreTypeStr
            student.mobileno = mobilenosStr
            student.status = status
            
            do {
                try DataBaseController.saveContext()
                
            } catch let error as NSError {
                
                print("Could not save. \(error), \(error.userInfo)")
            }
            return student.userid
        }
        else {
            let student = NSEntityDescription.insertNewObject(forEntityName: "Company", into: DataBaseController.persistentContainer.viewContext) as! Company
            
            let array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
            
            student.companyId = Int16(array[Int(arc4random_uniform(UInt32(array.count)))])
            student.name = nameStr
            student.email = emailStr
            student.password = passwordStr
            student.conformpassword = conformPasswordStr
            student.selectCountry = selectCountryStr
            student.selectCity = selectCityStr
            student.address = AddressStr
            student.link = selectStoreTypeStr
            student.mobileno = mobilenosStr
            student.status = status
            
            do {
                try DataBaseController.saveContext()
                
            } catch let error as NSError {
                
                print("Could not save. \(error), \(error.userInfo)")
            }
                return student.companyId
        }
     
    }
   
    
  
//     var parameters = ["name":nameStr,"email":emailStr,"password":passwordStr,"conformpassword":conformPasswordStr,"selectCountry":selectCountryStr,"selectCity":selectCityStr,"Address":AddressStr,"Link":selectStoreTypeStr,"mobile_no":mobilenosStr,"status":status]
//        let string_URL = "http://localhost/swami_api/Registration.php"
//        let myItemURL1 = "https://eber.elluminatiinc.com/citilist_selectedcountry"
//        
//        let headers = ["Content-Type":"Application/json"]
//        
//        Alamofire.request(string_URL, method:.post, parameters:parameters,headers:headers).responseJSON {
//            (responseObject) -> Void in
//            
//            print(responseObject)
//            
//            if responseObject.result.isSuccess {
//                
//                let resJson = (responseObject.result.value) as! [String:Any]
////            //    var succuess = resJson["success"] as! Bool
////                print(succuess)
////                    
//              
//                    DispatchQueue.main.async(execute: {
//                        
//                    })
//                    print("error")
//                }
//                
//            
//            
//            if responseObject.result.isFailure {
//                
//                let error: NSError = responseObject.result.error! as NSError
//                print(error)
//            }
//        }
//    }
//
//        
        
        
        
        
        
//        let url = URL.init(string: string_URL)
//        var requestss = URLRequest(url: url!)
//        requestss.httpBody = post.data(using: .utf8)
//        let tasks = URLSession.shared.dataTask(with: requestss) { (data, response, error) in
//        
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//            do {
//                //converting resonse to NSDictionary
//                let myJSON =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//                
//                //parsing the json
//                if let parseJSON = myJSON {
//                    
//                    //creating a string
//                    var msg : String!
//                    
//                    //getting the json response
//                    msg = parseJSON["message"] as! String?
//                    
//                    //printing the response
//                    print(msg)
//                    
//                }
//            } catch {
//                print(error)
//            }
//            
//        }
//        tasks.resume()
    
        
        
        
    }

