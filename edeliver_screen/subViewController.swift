//
//  subViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 04/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class subViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    var sub_objC_array = [String]()
    var sub_swift_array = [String]()
    var valu_seg = Int()
    var str1 = String()
    var value_top = Int()
    var objcarray = [String]()
    var swiftarray = [String]()
    
    var stringtopicName : String?
    var stringdescName : String?
    let navigationbar = UINavigationBar()
  var marrStudentData = NSMutableArray()
    @IBOutlet weak var subTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     

        
        if valu_seg == 0 {
            objcarray = sub_objC_array
            for i in 0..<sub_objC_array.count {
                print(objcarray[i])
            }
        }
        else{
            swiftarray = sub_swift_array
            for i in 0..<sub_swift_array.count {
                print(swiftarray[i])
            }
        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valu_seg == 0 {
            return objcarray.count
        }
        else{
            return swiftarray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtableviewcell")as! subTableViewCell
        if valu_seg == 0 {
            cell.subcell.text = objcarray[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else{
            cell.subcell.text  = swiftarray[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fetchdat = self.storyboard?.instantiateViewController(withIdentifier: "fetdata")as! fetchViewController
        
        if(valu_seg == 0){
           
            if(value_top == 0)
            {
                self.shortswift_INtroduction(vale: indexPath.row)
                
            }
            else if(value_top == 1)
            {
                self.shortfuncobjc_Basic(vale:indexPath.row)
            }
            else if(value_top == 2)
            {
                self.shortfuncobjc_advanced(vale: indexPath.row)            }
            else
            {
                self.shortfuncobjc_control(vale: indexPath.row)
            }
        }
        else{
            
            
            
            if(value_top == 0)
            {
                self.shortswift_INtroduction(vale: indexPath.row)
            }
            else if(value_top == 1)
            {
                self.shortswift_Basic(vale: indexPath.row)            }
            else if(value_top == 2)
            {
                self.shortswift_advanced(vale: indexPath.row)
            }
            else
            {
                self.shortswift_control(vale: indexPath.row)
            }
            
        }
        
        fetchdat.stringname = stringtopicName ?? "null"
        fetchdat.stringdesc = stringdescName ?? "null"
        
       self.navigationController?.pushViewController(fetchdat, animated: true)
    }
  
    
    func shortfunobjc_INtroduction(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"objc_Introduction",val:(vale as! Int) + 1)
        
        stringtopicName = String(describing: marrStudentData.object(at: 1) )
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortfuncobjc_Basic(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"objc_Basic",val: (vale as! Int) + 1)
     
        
        stringtopicName =  String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortfuncobjc_advanced(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"objc_Advanced",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortfuncobjc_control(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"objc_Controller",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func  shortswift_INtroduction(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"swift_Introduction",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortswift_Basic(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"swift_basic",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortswift_advanced(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"swift_advanced",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    func shortswift_control(vale:Any){
        marrStudentData = ModelManager.getInstance().getAllStudentData(tablenames:"swift_Controller",val: (vale as! Int) + 1)
        stringtopicName = String(describing: marrStudentData.object(at: 1))
        stringdescName = String(describing: marrStudentData.object(at: 2))
        print(vale)
    }
    @IBAction func showdatatut(segue: UIStoryboardSegue)
    {
        let fetchdata = segue.source as! fetchViewController
    }

}
