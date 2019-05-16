//
//  showjobViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class showjobViewController: UIViewController {

    var fetchJobArray : [Jobs] = []
    var resultdatadetch : [Company] = []
    
    @IBOutlet weak var descview: UITextView!
    var strinjobid = Int16()
    var jobnameStr = String()
    var experienceStr = String()
    var saleryStr = String()
    var urlStr = String()
    var locationAddressStr = String()
    var descriptionStr = String()
    @IBOutlet weak var jobname: UILabel!
    
    @IBOutlet weak var Companyname: UILabel!
    @IBOutlet weak var salary: UILabel!
    
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var experience: UILabel!
    
   
    @IBOutlet weak var locationAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchJobsD()
        jobname.text = jobnameStr
        salary.text = saleryStr
        experience.text = experienceStr
        locationAddress.text = locationAddressStr
        url.text = urlStr
        descview.text = descriptionStr
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchJobsD(){
        
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "Jobs" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"Jobs" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "jobId == %d",strinjobid as CVarArg)
        FetchReq.predicate = predicate
        
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            print(results)
            
            
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(FetchReq)
            self.fetchJobArray = result! as! [Jobs]
            print(fetchJobArray.count)
            
            for object in fetchJobArray {
                print(object.companyid ?? "nil")
              
       self.fetchname(id: object.companyid)
            }
      
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }

    }
    func fetchname(id:Int16){
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "Company" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"Company" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "companyId == %d",id as CVarArg)
        FetchReq.predicate = predicate
        
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            print(results)
            
            
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(FetchReq)
            self.resultdatadetch = result! as! [Company]
            print(resultdatadetch .count)
            
            for object in resultdatadetch  {
                print(object.name ?? "nil")
                Companyname.text! = object.name!
                
            }
            
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }

    }


}
