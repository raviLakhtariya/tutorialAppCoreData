//
//  createjobsViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class createjobsViewController: UIViewController {

    let userdataFetch = saveUserdata()
    var cid = Int16()
    var cemail = String()
    var cpassword = String()
    var cstatus = Bool()
   
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    let array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
    @IBOutlet weak var jobname: UITextField!
    
    @IBOutlet weak var experience: UITextField!
    
    @IBOutlet weak var ddesc: UITextView!
    
    @IBOutlet weak var applylink: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var salary: UITextField!
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barButton.target = revealViewController()
        
        barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.fetchDatas()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addJobAction(_ sender: Any) {
        if jobname.text?.isEmpty == true || experience.text?.isEmpty == true || salary.text?.isEmpty == true || location.text?.isEmpty == true ||
            applylink.text?.isEmpty == true || ddesc.text?.isEmpty == true {
            self.alert(title: "Field", msge:"Insert field", flag: false)
        }else{
           self.fetchDatas()
            self.getCompanyDetail(email: cemail, id: cid)
        }
        
        
       
    }
 

    func fetchDatas(){
       var (cids,cemails,cpasswords,cstatuss) = userdataFetch.getData()
        self.cid = cids
        self.cemail = cemails
        self.cpassword = cpasswords
        self.cstatus = cstatuss
        
    }
    
    func alert(title:String,msge:String,flag:Bool){
        
        let alertController = UIAlertController.init(title:title, message: msge, preferredStyle: .alert)
        
        let alertAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
            if flag == true {
                
            //    self.performSegue(withIdentifier: "listview", sender: self)
            }
            else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCompanyDetail(email:String,id:Int16){
        let jobposts:Jobs = NSEntityDescription.insertNewObject(forEntityName: "Jobs", into: DataBaseController.persistentContainer.viewContext) as! Jobs
        jobposts.companyid = id
        jobposts.jobId = Int16(array[Int(arc4random_uniform(UInt32(array.count)))])
        jobposts.jobname = self.jobname.text!
        jobposts.salery = self.salary.text!
        jobposts.experience = self.experience.text!
        jobposts.location = self.location.text!
        jobposts.applylink = self.applylink.text!
        jobposts.jobdesc = self.ddesc.text!
        
        
        do {
            try DataBaseController.saveContext()
            
            self.alert(title:"save" ,msge:"successfully",flag: true)
        } catch let error as NSError {
            
            self.alert(title:"save",msge:" not successfully",flag: false)
            
            print("Could not save. \(error), \(error.userInfo)")
        }


    }
   

    
    
}
