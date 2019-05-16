//
//  createPostViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class createPostViewController: UIViewController {
    var ids = Int16()
    let appdel = AppDelegate()
    var isEdit : Bool = false
    var object : Userpost!
    var resultData : [Userpost] = []
    var flag = Bool()
    var msg = String()
    var storedataMember = storeData()
    @IBOutlet weak var postTitle_txtfield: UITextField!
    var stds: Userpost!
    var stdss : Companypost!
    var status = Bool()
    var selectVal = Int16()
    let array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
 

    @IBOutlet weak var postDesc_txtfield: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectVal = Int16(array[Int(arc4random_uniform(UInt32(array.count)))])
        print("\(storedataMember.id) and \(ids)")
        if(isEdit)
        {
            if status == false {
            postTitle_txtfield.text = stds.postTitle;
           postDesc_txtfield.text = stds.postDescription;
            }
            else {
                postTitle_txtfield.text = stdss.postTitle;
                postDesc_txtfield.text = stdss.postDescription;
            }
            
            
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButton(_ sender: Any) {
          self.performSegue(withIdentifier: "listview", sender: self)
    }

    @IBAction func saveAction(_ sender: Any) {
        if isEdit == false {
            self.save(name: postTitle_txtfield.text!, mark: postDesc_txtfield.text!)
        }
        else{
            self.updateStudentData()
        }
    }
   
    func save(name: String, mark : String) {
        
        if isEdit == false{
            if status == false {
            let student = NSEntityDescription.insertNewObject(forEntityName: "Userpost", into: DataBaseController.persistentContainer.viewContext) as! Userpost
            student.userid = ids
                student.postid = selectVal
            student.postTitle = self.postTitle_txtfield.text!
            student.postDescription = self.postDesc_txtfield.text!
            
            do {
                try DataBaseController.saveContext()
                
                flag = true
                
                self.alert(title:"save" ,msge:"successfully",flag: true)
            } catch let error as NSError {
                flag = false
                msg = " not successfully"
                self.alert(title:"save",msge:" not successfully",flag: false)
                
                print("Could not save. \(error), \(error.userInfo)")
            }
            }
            else{
                let student = NSEntityDescription.insertNewObject(forEntityName: "Companypost", into: DataBaseController.persistentContainer.viewContext) as! Companypost
                student.companyid = ids
                student.postid = selectVal
                student.postTitle = self.postTitle_txtfield.text!
                student.postDescription = self.postDesc_txtfield.text!
                
                do {
                    try DataBaseController.saveContext()
                    
                    flag = true
                    
                    self.alert(title:"save" ,msge:"successfully",flag: true)
                } catch let error as NSError {
                    flag = false
                    msg = " not successfully"
                    self.alert(title:"save",msge:" not successfully",flag: false)
                    
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        else if isEdit == true {
            self.updateStudentData()
        }
        self.AddPosts()
    }
    
    
    
    
    
    
    func alert(title:String,msge:String,flag:Bool){
        
        let alertController = UIAlertController.init(title:title, message: msge, preferredStyle: .alert)
        
        let alertAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            if flag == true {
                
                self.performSegue(withIdentifier: "listview", sender: self)
            }
            else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    

    func updateStudentData(){
        
        if status == false {
            
            
            let FetchReq:NSFetchRequest<NSFetchRequestResult>
            FetchReq = NSFetchRequest.init(entityName: "Userpost" as String)
            FetchReq.entity = NSEntityDescription.entity(forEntityName:"Userpost" as String, in: DataBaseController.persistentContainer.viewContext)
            let predicate = NSPredicate.init(format: "userid == %d", storedataMember.id as! CVarArg)
            FetchReq.predicate = predicate
            do {
                
                let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
                
                
                let dictTemp:NSMutableDictionary = NSMutableDictionary.init()
                
                dictTemp.setValue(postTitle_txtfield.text!, forKey: "postTitle");
                dictTemp.setValue(postDesc_txtfield.text!, forKey: "postDescription");
                
                let arrTemp:NSMutableArray = NSMutableArray.init()
                arrTemp.add(dictTemp)
                
                for insertData in results {
                    for i:NSInteger in 0 ..< arrTemp.count {
                        let objectRecord:NSDictionary = arrTemp.object(at: i) as! NSDictionary
                        for key in objectRecord.allKeys {
                            (insertData as AnyObject).setValue(objectRecord.value(forKey: key as! String), forKey: key as! String)
                        }
                    }
                }
                
                do {
                    try DataBaseController.saveContext()
                    
                    flag = true
                    
                    self.alert(title:"update",msge:"successfully",flag: true)
                } catch let error as NSError {
                    flag = false
                    msg = " not successfully"
                    self.alert(title:"update",msge:" not successfully",flag: false)
                    
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            } catch  {
                fatalError("Failed to fetch employees: \(error)")
            }
            

            
        }
        else{
            let FetchReq:NSFetchRequest<NSFetchRequestResult>
            FetchReq = NSFetchRequest.init(entityName: "Companypost" as String)
            FetchReq.entity = NSEntityDescription.entity(forEntityName:"Companypost" as String, in: DataBaseController.persistentContainer.viewContext)
            let predicate = NSPredicate.init(format: "companyid == %d", storedataMember.id as! CVarArg)
            FetchReq.predicate = predicate
            do {
                
                let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
                
                
                let dictTemp:NSMutableDictionary = NSMutableDictionary.init()
                
                dictTemp.setValue(postTitle_txtfield.text!, forKey: "postTitle");
                dictTemp.setValue(postDesc_txtfield.text!, forKey: "postDescription");
                
                let arrTemp:NSMutableArray = NSMutableArray.init()
                arrTemp.add(dictTemp)
                
                for insertData in results {
                    for i:NSInteger in 0 ..< arrTemp.count {
                        let objectRecord:NSDictionary = arrTemp.object(at: i) as! NSDictionary
                        for key in objectRecord.allKeys {
                            (insertData as AnyObject).setValue(objectRecord.value(forKey: key as! String), forKey: key as! String)
                        }
                    }
                }
                
                do {
                    try DataBaseController.saveContext()
                    
                    flag = true
                    
                    self.alert(title:"update",msge:"successfully",flag: true)
                } catch let error as NSError {
                    flag = false
                    msg = " not successfully"
                    self.alert(title:"update",msge:" not successfully",flag: false)
                    
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
            } catch  {
                fatalError("Failed to fetch employees: \(error)")
            }
            

        }
        
    }
    
    func AddPosts(){
        
        if status == false {
            let posts:Posts = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: DataBaseController.persistentContainer.viewContext) as! Posts
            posts.userid = ids
            posts.comapnyid = 0
            posts.postid = selectVal
            posts.posttitle = self.postTitle_txtfield.text!
            posts.postdescriptions = self.postDesc_txtfield.text!
            
            do {
                try DataBaseController.saveContext()
                
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

        }
        else{
            let posts:Posts = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: DataBaseController.persistentContainer.viewContext) as! Posts
            posts.userid = 0
            posts.comapnyid = ids
            posts.postid = selectVal
            posts.posttitle = self.postTitle_txtfield.text!
            posts.postdescriptions = self.postDesc_txtfield.text!
            
            do {
                try DataBaseController.saveContext()
                
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

        }
    }
}

