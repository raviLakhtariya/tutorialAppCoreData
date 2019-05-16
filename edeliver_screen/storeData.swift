//
//  storeData.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import Foundation
import CoreData

class storeData {
    
  let getDataFromUserDefault = saveUserdata()
    var id : Int16?
    var nameStrs : String?
    var emailStrs : String?
    var passwordStrs : String?
    var city : String?
    var country : String?
    var address : String?
    var link : String?
    var mobileno : String?
    var status : Bool?
    
    func getData(){
          let (ids,emails,passwords,statuss) = self.getDataFromUserDefault.getData()
        self.id = ids
        self.emailStrs = emails
        self.passwordStrs = passwords
        self.status = statuss
        
    }

    
           
        
        
    

//    func storeUserLoginData(){
//        let FetchReq:NSFetchRequest<NSFetchRequestResult>
//        FetchReq = NSFetchRequest.init(entityName: "User" as String)
//        FetchReq.entity = NSEntityDescription.entity(forEntityName:"User" as String, in: DataBaseController.persistentContainer.viewContext)
//        let predicate = NSPredicate.init(format: "email == %@", email.text! as CVarArg)
//        FetchReq.predicate = predicate
//        
//        
//        do {
//            
//            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
//            print(results)
//            
//            
//            
//            let stdt = DataBaseController.persistentContainer.viewContext
//            let result = try? stdt.fetch(FetchReq)
//            self.resultData = result! as! [User]
//            print(resultData.count)
//            
//            for object in resultData {
//                
//                print(object.email ?? "nil")
//                print(object.password ?? "nil")
//                
//                emaildd = object.email ?? "nil"
//                passwordd = object.password ?? "nil"
//                
//                print(emaildd)
//                print(passwordd)
//            }
//            
//        } catch  {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//        
//        
//        
//        
//
//    }
}
