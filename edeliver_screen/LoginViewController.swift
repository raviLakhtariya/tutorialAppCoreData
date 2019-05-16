//
//  LoginViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 16/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController,TabBarSwitcher,UITextFieldDelegate {
    var id_user = Int16()
    
    
    @IBOutlet weak var CompanyFlag_button: UIButton!
    @IBOutlet weak var UserFlag_button: UIButton!
    var isselect1 = Bool()
    var isselect2 = Bool()
    var vl = Bool()
    var emaildd = String()
    var passwordd = String()
var resultData : [User] = []
    var objectStatus = Bool()
    
    @IBOutlet weak var Login_tabbarItem: UITabBarItem!
  
    var selectRadio = UIImage.init(named: "icons8-unchecked-radio-button-filled-50.png");
    
    var unselectRadio = UIImage.init(named: "icons8-unchecked-radio-button-50.png")

      let setuserData = saveUserdata()
    
    @IBOutlet weak var email: FloatLabelTextField!
    
    @IBOutlet weak var password: FloatLabelTextField!
    
    @IBOutlet weak var language: FloatLabelTextField!
    
    @IBOutlet weak var frameview: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    var userdatafetch = saveUserdata()
    var setuserdata = saveUserdata()
    var emailString = String()
    var passwordString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.ifData()
        var  vl = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
         initSwipe(.left)
        self.initializeTextFields()

        
        UserFlag_button.addTarget(self, action:#selector(UserButton(_:)), for: UIControlEvents.touchUpInside)
        
        isselect1 = false
        isselect2 = false
        UserFlag_button.setImage(unselectRadio, for: .normal)
        
        CompanyFlag_button.addTarget(self, action:#selector(CompanyButton(_:)), for: UIControlEvents.touchUpInside)
        
        

        self.frameview
            .addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapgesturef(gesture:))))
        

          }
    func tapgesturef(gesture:UITapGestureRecognizer){
        self.frameview.endEditing(true)
                       
        resignFirstResponder()
    }

    func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            tabBarController?.selectedIndex = 1
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.scrollview.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.scrollview.frame = CGRect(x: self.scrollview.frame.origin.x,
                                     y: self.scrollview.frame.origin.y,
                                     width: self.scrollview.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height )
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
        
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.scrollview.frame.height
            self.scrollview.frame = CGRect(x: self.scrollview.frame.origin.x,
                                     y: self.scrollview.frame.origin.y,
                                     width: self.scrollview.frame.width,
                                     height: viewHeight + keyboardSize.height)
            
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
        adjustingHeight(show: false, notification: notification)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      print(emailString)
        print(passwordString)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        _ = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        _ = (keyboardFrame.height + 40) * (show ? 1 : -1)
        //5
        
        //    UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
        //            self.bottomConstraint.constant += changeInHeight
        //        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initializeTextFields() {
        
        language.delegate = self
        language.keyboardType = UIKeyboardType.default
        language.tag = 3
        
        email.delegate = self
        email.keyboardType = UIKeyboardType.emailAddress
        email.tag = 1
        email.becomeFirstResponder()

        
        password.delegate = self
        password.keyboardType = UIKeyboardType.default
        password.tag = 2
        
      
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextfield = (textField.superview?.viewWithTag(textField.tag + 1) as? UITextField) {
            nextfield.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        //  textField.resignFirstResponder()
        // Do not add a line break
        return false
    }

   
    func ifData(){
        let(idusers,emailData,passwordData,vlbool) = self.setuserData.getData()
        print(idusers)
        print(emailData)
        print(passwordData)
        print(vlbool)
        if emailData.containsOnlyCharactersIn("email is null") == true || passwordData.containsOnlyCharactersIn("password is null") == true  {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            
            let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "home")as! homeViewController
            self.navigationController?.pushViewController(homeScreen, animated: true)

        }
    }
    
    
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        self.loginfunct()
        if (email.text?.isEmpty)! && (password.text?.isEmpty)! && (language.text?.isEmpty)! {
            self.alert(title: "Login", message: "Insert field", value: false)
        }
        else{
        if emaildd.containsOnlyCharactersIn(email.text!) == true  && passwordd.containsOnlyCharactersIn(password.text!) == true  {
           
            let val =   self.setuserdata.setdata(email: self.email.text!, password: self.password.text!,status:vl)
       
            if val == true {
             
                var storedatas = storeData()
                storedatas.id = id_user
                
             
                
                self.alert(title: "Login", message: "successfullly", value: true)
   
                
            
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if emaildd.containsOnlyCharactersIn(email.text!) == true && passwordd.doesNotContainCharactersIn(password.text!) == false{
            
            self.alert(title: "password", message: "password does not match", value: false)
            
        }else if emaildd.doesNotContainCharactersIn(email.text!) == false && passwordd.containsOnlyCharactersIn(password.text!) == true {
            
            self.alert(title: "email", message: "email does not match", value: false)
            
        }else {
            
            self.alert(title: "email & password", message: "both are incorrect", value: false)
        }
        }
        
    }
  
   
    func alert(title:String,message:String,value:Bool){
        
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "ok", style: .default) { (UIAlertAction) in
         
            if value == true {
               
                let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "home")as! homeViewController
                self.navigationController?.pushViewController(homeScreen, animated: true)
        
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
               alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    
    }
    @IBAction func Login(segue: UIStoryboardSegue){
        let homeController = segue.source as! homeViewController
      
    }
    @IBAction func Logins(segue: UIStoryboardSegue)
    {
        let logoutScreen = segue.source as! logoutViewController
    }
   
    @IBAction func CompanyButton(_ sender: Any) {
        if isselect2 == false{
            vl = true
            isselect2 = true
            CompanyFlag_button.setImage(selectRadio, for: .normal)
            UserFlag_button.setImage(unselectRadio, for: .normal);isselect1 = false
        }

    }
    
    @IBAction func UserButton(_ sender: Any) {
        if isselect1 == false {
            vl = false
            isselect1 = true
            UserFlag_button.setImage(selectRadio, for: .normal)
            CompanyFlag_button.setImage(unselectRadio, for: .normal);isselect2 = false
        }
    }
   
    
    
    func loginfunct(){
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "User" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"User" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "email == %@", email.text! as CVarArg)
     FetchReq.predicate = predicate
        
        
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            print(results)
           
          
            
            let stdt = DataBaseController.persistentContainer.viewContext
            let result = try? stdt.fetch(FetchReq)
            self.resultData = result! as! [User]
            print(resultData.count)
            
            for object in resultData {
                
                print(object.email ?? "nil")
                print(object.password ?? "nil")
                
                emaildd = object.email ?? "nil"
                passwordd = object.password ?? "nil"
                
                print(emaildd)
                print(objectStatus)
                print(passwordd)
            }

        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        
        
        
    }

}

