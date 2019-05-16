//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    var tablename = String()
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("databas.db"))
        }
        return sharedInstance
    }
    
    func addStudentData(_ studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO \(tablename) (topic_name, topic_desc) VALUES (?, ?)", withArgumentsIn: [studentInfo.topic_name, studentInfo.topic_desc])
        sharedInstance.database!.close()
        return isInserted
    }
   
    func updateStudentData(_ studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE \(tablename) SET Name=?, Marks=? WHERE RollNo=?", withArgumentsIn: [studentInfo.topic_name, studentInfo.topic_desc, studentInfo.topic_id])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteStudentData(_ studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM \(tablename) WHERE topic_id=?", withArgumentsIn: [studentInfo.topic_id])
        sharedInstance.database!.close()
        return isDeleted
    }

    func getAllStudentData(tablenames:String,val:Int) -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(tablenames) where topic_id = \(val)", withArgumentsIn: nil)
        
        
        var marrStudentInfo : NSMutableArray = NSMutableArray()
      
        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : StudentInfo = StudentInfo()
                studentInfo.topic_id = resultSet.string(forColumn: "topic_id")
                studentInfo.topic_name = resultSet.string(forColumn: "topic_name")
                studentInfo.topic_desc = resultSet.string(forColumn: "topic_desc")
                marrStudentInfo.add(studentInfo.topic_id)
                marrStudentInfo.add(studentInfo.topic_name)
                marrStudentInfo.add(studentInfo.topic_desc)
            }
        }
       
        print(marrStudentInfo)
        sharedInstance.database!.close()
        return marrStudentInfo
    }
}
