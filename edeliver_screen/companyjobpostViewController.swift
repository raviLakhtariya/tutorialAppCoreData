//
//  companyjobpostViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData

class companyjobpostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    var arrays = NSMutableArray()
     var resultDatas : [Company] = []
    
    var JobResult : [Jobs] = []
       let userdataFetch = saveUserdata()
    var companyJobArray : [Companyjob] = []
    var JobArray : [Jobs] = []
    var userData = storeData()
    var cid = Int16()
    var cemail = String()
    var cpassword = String()
    var cstatus = Bool()

    @IBOutlet weak var tableview: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.fetchDatas()
       barButton.target = revealViewController()
        
        barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let std:NSFetchRequest<Jobs> = Jobs.fetchRequest()
        do{
            self.JobArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
            print(JobArray)
            
        } catch{
            print(error.localizedDescription)
        }
        self.tableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      
        
            return JobArray.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = self.tableview.dequeueReusableCell(withIdentifier: "companyjobcell") as! companyjobTableViewCell
        
        
        
       
            let stdarrau = JobArray[indexPath.row]
            
            print(stdarrau)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                       reuseIdentifier: "yourpost") as! companyjobTableViewCell
            }
            
        
            cell.jobName.text! = stdarrau.jobname!
            cell.RequExp.text! = stdarrau.experience!
            cell.locationA.text! = stdarrau.location!
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createPostScreen = self.storyboard?.instantiateViewController(withIdentifier: "showjob")as! showjobViewController
     
        
           let stdary = JobArray[indexPath.row]
        createPostScreen.strinjobid = stdary.jobId
        createPostScreen.jobnameStr = stdary.jobname!
        createPostScreen.saleryStr = stdary.salery!
        createPostScreen.experienceStr = stdary.experience!
        createPostScreen.locationAddressStr = stdary.location!
        createPostScreen.descriptionStr = stdary.jobdesc!
        createPostScreen.urlStr = stdary.applylink!
        
        
            
        
        self.navigationController?.pushViewController(createPostScreen, animated: true)
    }
    func fetchDatas(){
        var (cids,cemails,cpasswords,cstatuss) = userdataFetch.getData()
        self.cid = cids
        self.cemail = cemails
        self.cpassword = cpasswords
        self.cstatus = cstatuss
       
    }
    
    @IBAction func companyjobpost(segue: UIStoryboardSegue)
    {
        let showjob = segue.source as! showjobViewController
    }
          }

