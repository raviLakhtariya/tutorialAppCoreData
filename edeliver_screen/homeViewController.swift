//
//  homeViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 24/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class homeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var removedata = saveUserdata()
 
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var hometableview: UITableView!
    
    
    @IBOutlet weak var profile_Button: UIButton!
    @IBOutlet weak var menushow: UIBarButtonItem!
  
    let objc_INtroduction = ["Introduction","Steave Jobs","About Iphone Industry","History"]as [String]
    let objc_Basic = ["Introduction","Constant & variables","Type Annotation","Operators","NSNumber","NSString and NSMutableString","NSArray and NSMutableArray","NSDictionary and NSMutableDictionary","Protocol"]as [String]
    
    let objc_advanced = ["IBoutlet","IBaction","UIAlertView","UActionSheet", "UIsegmentControl","UIPicketView","UIDatePickerView","UIImagePicker","Navigation","UITableView","slider","ProgressView"]as [String]
  
   let objc_controls = ["First IPHONE Application","Actions And Outlets","Delegates","UI Elements","Text Field","Input Types - TextFields","Buttons","Label","Tollbar","Statusbar","Navigationbar","Tab bar","ImageView","ScrollView","TableView","TextView","CollectionView","PickerView","Switches","Sliders","Alerts","Icons","Accelerometer","Universal Application","Camera Management","Location Handling","SQLITEDatabase","Sending Mail & Messages","Audio & video","File Handling","Accessing Maps","Auto Layout","Persist Data","Parsing"]as [String]
  
    let arr_objC = ["objc_INtroduction","objc_Basic","objc_advanced","objc_controls"] as [String]
 
    let swift_INtroduction = ["Introduction","Steave Jobs","About Iphone Industry","History"] as [String]

    let swift_Basic = ["Introduction","Constant & variables","Type Annotation","Operators","Optionals","Conditional Statements","While loops","For loops","Control Transfer statement","String","Working with String","Arrays","Modifying an Array","Sets","Set Operations","Dictionaries","Functions","Closures","Tuples","Enumrations"] as [String]

    let swift_advanced = ["Classes and Structures","Classes vs Structures","Properties","Methods", "Subscripts","Inheritance","Initialization","Deinitialization"] as [String]

    let swift_controls = ["First IPHONE Application","Actions And Outlets","Delegates","UI Elements","Text Field","Input Types - TextFields","Buttons","Label","Tollbar","Statusbar","Navigationbar","Tab bar","ImageView","ScrollView","TableView","TextView","CollectionView","PickerView","Switches","Sliders","Alerts","Icons","Accelerometer","Universal Application","Camera Management","Location Handling","SQLITEDatabase","Sending Mail & Messages","Audio & video","File Handling","Accessing Maps","Auto Layout","Persist Data","parsing"]as [String]
    let arr_swift = ["swift_INtroduction","swift_Basic","swift_advanced","swift_controls"] as [String]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile_Button.layer.borderWidth = 2
        profile_Button.layer.borderColor = UIColor.white.cgColor
        profile_Button.layer.masksToBounds = false
        profile_Button.layer.cornerRadius = profile_Button.frame.height/2
        profile_Button.clipsToBounds = true
//        image.layer.borderWidth = 1
//        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.blackColor().CGColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true
       menushow.target = revealViewController()
        
        menushow.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       //  Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func alert(title:String,message:String,value:Bool){
        
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "ok", style: .default) { (UIAlertAction) in
            
            if value == true {
                self.performSegue(withIdentifier:"logout", sender: self)                
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentOutlet.selectedSegmentIndex == 0 {
            return arr_objC.count
        }
        else{
          return arr_swift.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell")as! homeTableViewCell
        if segmentOutlet.selectedSegmentIndex == 0 {
           cell.mainTopicLabel.text = arr_objC[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else{
            cell.mainTopicLabel.text  = arr_swift[indexPath.row]
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subScreen = self.storyboard?.instantiateViewController(withIdentifier: "subScreen")as! subViewController
        
        if segmentOutlet.selectedSegmentIndex == 0 {
            subScreen.valu_seg = 0
            if indexPath.row == 0 {
                subScreen.sub_objC_array = objc_INtroduction
                subScreen.str1 = "objC_Introduction"
                subScreen.value_top = 0
            }else if indexPath.row == 1 {
                subScreen.sub_objC_array = objc_Basic
                subScreen.str1 = "objC_Basic"
                subScreen.value_top = 1
            }
            else if indexPath.row == 2 {
                subScreen.sub_objC_array = objc_advanced
                subScreen.str1 = "objC_advanced"
                subScreen.value_top = 2
            }else{
                subScreen.sub_objC_array = objc_controls
                subScreen.str1 = "objC_Controller"
                subScreen.value_top = 3
            }
        }
        else{
            subScreen.valu_seg = 1
            if indexPath.row == 0 {
                subScreen.sub_swift_array = swift_INtroduction
                subScreen.str1 = "swift_Introduction"
                subScreen.value_top = 0
            }else if indexPath.row == 1 {
                subScreen.sub_swift_array = swift_Basic
                subScreen.str1 = "swift_Basic"
                subScreen.value_top = 1
            }
            else if indexPath.row == 2 {
                subScreen.sub_swift_array = swift_advanced
                subScreen.str1 = "swift_advanced"
                subScreen.value_top = 2
            }else{
                subScreen.sub_swift_array = swift_controls
                subScreen.str1 = "swift_Controller"
                subScreen.value_top = 3
            }

        }
 
        self.navigationController?.pushViewController(subScreen, animated: true)

    }
    
    @IBAction func profile(segue: UIStoryboardSegue)
    {
        let profileScreen = segue.source as! ProfileViewController
    }

    @IBAction func subtopic(segue: UIStoryboardSegue)
    {
        let subtopic = segue.source as! subViewController
    }

    
    
    
    @IBAction func segmentAction(_ sender: Any) {
        if segmentOutlet.selectedSegmentIndex == 0 {
            hometableview.reloadData()
        }
        else{
            hometableview.reloadData()
        }


    }
  
}
