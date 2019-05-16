//
//  yourPostListViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class yourPostListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var userid = Int16()
    var userStatus = Bool()
    
    var userPostArray : [Userpost] = []
    var companyPostArray : [Companypost] = []
    var postArray : [Posts] = []
    @IBOutlet weak var tableview: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func backButton(_ sender: Any) {
         self.performSegue(withIdentifier:"yourpostback", sender: self)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if userStatus == false{
//            let std:NSFetchRequest<Userpost> = Userpost.fetchRequest()
//            do{
//                self.userPostArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
//                print(userPostArray)
//                
//            } catch{
//                print(error.localizedDescription)
//            }
//           
//            
//
//        }else if userStatus == true{
//            let std:NSFetchRequest<Companypost> = Companypost.fetchRequest()
//            do{
//                self.companyPostArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
//                print(companyPostArray)
//                
//            } catch{
//                print(error.localizedDescription)
//            }
//           
//            
//
//        }
//        if self.userPostArray.count == 0 || self.companyPostArray.count == 0 {
//            
//            self.tableview.reloadData()
//        }else{
//            
//            
//            
//            if userStatus == false{
//                let std:NSFetchRequest<Userpost> = Userpost.fetchRequest()
//                do{
//                    self.userPostArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
//                    print(userPostArray)
//                    
//                } catch{
//                    print(error.localizedDescription)
//                }
//                
//                
//                
//            }else if userStatus == true{
//                let std:NSFetchRequest<Companypost> = Companypost.fetchRequest()
//                do{
//                    self.companyPostArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
//                    print(companyPostArray)
//                    
//                } catch{
//                    print(error.localizedDescription)
//                }
//                
//                
//                
//            }
//            
//            
//  }
         
        self.datarefresh()
  
    }
    func datarefresh(){
 
        if userStatus == false{
            
            self.dataRefreshUser()
           // self.tableview.reloadData()
        }
        else if userStatus == true {
            
            self.dataRefreshCompany()
           // self.tableview.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if userStatus == false{
             return userPostArray.count
        }
        else {
            return companyPostArray.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = self.tableview.dequeueReusableCell(withIdentifier: "yourpost") as! yourpostCellTableViewCell
        if userStatus == false {
            let stdarrau = userPostArray[indexPath.row]
            
            print(stdarrau)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                       reuseIdentifier: "yourpost") as! yourpostCellTableViewCell
            }
            
            
            cell.postTitle.text! = stdarrau.postTitle!
            cell.postsubTitle.text! = stdarrau.postDescription!
            
            
        }
        else{
            let stdarrau = companyPostArray[indexPath.row]
            
            print(stdarrau)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                       reuseIdentifier: "yourpost") as! yourpostCellTableViewCell
            }
            
            
            cell.postTitle.text! = stdarrau.postTitle!
            cell.postsubTitle.text! = stdarrau.postDescription!
            
        }
        cell.editButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createPostScreen = self.storyboard?.instantiateViewController(withIdentifier: "createpost")as! createPostViewController
        
        if userStatus == false{
        createPostScreen.stds = userPostArray[indexPath.row]
        createPostScreen.ids = userid
            createPostScreen.status = userStatus
        }
        else{
            createPostScreen.stdss = companyPostArray[indexPath.row]
            createPostScreen.ids = userid
            createPostScreen.status = userStatus

        }
        self.navigationController?.pushViewController(createPostScreen, animated: true)
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        
        if userStatus == false {
            
            
            
            
            
            
            
            let btnDelete : UIButton = sender as! UIButton
            let selectedIndex : Int = btnDelete.tag
            //studentArray[selectedIndex] as! StudentDetails
            
            let fetchRequest = NSFetchRequest<Userpost>(entityName: "Userpost")
            let predicate = NSPredicate(format: "postid = %d",userPostArray[selectedIndex].postid as CVarArg)
            print(userPostArray[selectedIndex].postid)
            fetchRequest.predicate = predicate
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(fetchRequest)
            let resultData = result! as [Userpost]
            for object in resultData {
                stdt.delete(object)
            }
            do {
                try stdt.save()
                print("saved")
            }catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            
            
            let fetchRequest1 = NSFetchRequest<Posts>(entityName: "Posts")
            let predicate1 = NSPredicate(format: "postid = %d",userPostArray[selectedIndex].postid as CVarArg)
           // print(postArray[selectedIndex].postid)
            fetchRequest1.predicate = predicate1
            
            let stdt1 = DataBaseController.persistentContainer.viewContext
            let result1s = try? stdt1.fetch(fetchRequest1)
            let resultData1 = result1s! as [Posts]
            for object1 in resultData1 {
                stdt1.delete(object1)
            }
            do {
                try stdt1.save()
                print("saved")
            }catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            

            self.datarefresh()

        }else{
            let btnDelete : UIButton = sender as! UIButton
            let selectedIndex : Int = btnDelete.tag
            //studentArray[selectedIndex] as! StudentDetails
            
            let fetchRequest = NSFetchRequest<Companypost>(entityName: "Companypost")
            let predicate = NSPredicate(format: "postid = %d",companyPostArray[selectedIndex].postid as CVarArg)
            fetchRequest.predicate = predicate
               print(companyPostArray[selectedIndex].postid)
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(fetchRequest)
            let resultData = result! as [Companypost]
            for object in resultData {
                stdt.delete(object)
            }
            do {
                try stdt.save()
                print("saved")
            }catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            let fetchRequest1 = NSFetchRequest<Posts>(entityName: "Posts")
            let predicate1 = NSPredicate(format: "postid = %d",companyPostArray[selectedIndex].postid as CVarArg)
          //  print(postArray[selectedIndex].postid)
            fetchRequest1.predicate = predicate1
            
            let stdt1 = DataBaseController.persistentContainer.viewContext
            let result1s = try? stdt1.fetch(fetchRequest1)
            let resultData1 = result1s! as [Posts]
            for object1 in resultData1 {
                stdt1.delete(object1)
            }
            do {
                try stdt1.save()
                print("saved")
            }catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            

            self.datarefresh()

        }
         }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editSegue")
        {
            if userStatus == false {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewscreen : createPostViewController = segue.destination as! createPostViewController
            viewscreen.isEdit = true
            viewscreen.stds = userPostArray[selectedIndex] 
            }
            else{
                let btnEdit : UIButton = sender as! UIButton
                let selectedIndex : Int = btnEdit.tag
                let viewscreen : createPostViewController = segue.destination as! createPostViewController
                viewscreen.isEdit = true
                viewscreen.stdss  = companyPostArray[selectedIndex]

            }
        }
    }
    
  
    @IBAction func createPostButon(_ sender: Any) {
        let createPostScreens = self.storyboard?.instantiateViewController(withIdentifier: "createpost")as! createPostViewController;
        createPostScreens.ids = userid
        createPostScreens.status = userStatus

        self.navigationController?.pushViewController(createPostScreens, animated: true)
    }
    
    @IBAction func saveNames(segue: UIStoryboardSegue) {
        let createController = segue.source as! createPostViewController
        // Address.text = saveController.addressString
        
        
    }
    func dataRefreshUser(){
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "Userpost" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"Userpost" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "userid == %d", userid as CVarArg)
        FetchReq.predicate = predicate
        
        
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            print(results)
            
            
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(FetchReq)
            self.userPostArray = result! as! [Userpost]
            print(userPostArray.count)
            
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }
        self.tableview.reloadData()
    }
    
    
    func dataRefreshCompany(){
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "Companypost" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"Companypost" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "companyid == %d", userid as CVarArg)
        FetchReq.predicate = predicate
        
        
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            print(results)
            
            
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(FetchReq)
            self.companyPostArray = result! as! [Companypost]
            print(companyPostArray.count)
            
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }
        self.tableview.reloadData()
    }

    @IBAction func createPostView(segue: UIStoryboardSegue)
    {
        let createPostScreenView = segue.source as! createPostViewController
    }
}
