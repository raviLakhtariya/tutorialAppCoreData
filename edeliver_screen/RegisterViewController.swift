//
//  RegisterViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 16/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UserNotifications


class RegisterViewController: UIViewController,TabBarSwitcher,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var useid = Int16()
       var url_string = "https://eber.elluminatiinc.com/country_list/"
      var countrynm : String!
var st = Bool()
    
    @IBOutlet weak var CompanyFlag_button: UIButton!
    @IBOutlet weak var UserFlag_button: UIButton!
    var isselect1 = Bool()
    var isselect2 = Bool()
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var close_button: UIButton!
    let myTables = myTable()

    @IBOutlet weak var frameview: UIView!
    var myresponse : JSON = nil
   
    var countriess = NSMutableArray()
   
    var countries : [Country] = []
      var citiess = NSMutableArray()
    var cities : [City] = []
    
    var numberofrow = Int()
   
    var textfieldChooseName = String()
  
    var whitespaceCon = WhiteSpaceC()
 var mobilenos = String()
   
    var imagePicker = UIImagePickerController()

 
   

    @IBOutlet var view_outlet: UIView!
    
    var setuserdata = saveUserdata()
    
    @IBOutlet weak var tableview: UITableView!
  
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var name: FloatLabelTextField!
    
    @IBOutlet weak var email: FloatLabelTextField!
    
    @IBOutlet weak var password: FloatLabelTextField!
    
    @IBOutlet weak var conformPassword: FloatLabelTextField!
    
    @IBOutlet weak var selectCountry: FloatLabelTextField!
    
    @IBOutlet weak var selectCity: FloatLabelTextField!
    
    @IBOutlet weak var selectStoreType: FloatLabelTextField!
    
    @IBOutlet weak var Address: FloatLabelTextField!
   
    var addressString : String = ""

    var countryCode = String()
   
    @IBOutlet weak var mobileno: FloatLabelTextField!
    
  
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var ischecked = false
   
    @IBOutlet weak var registerButton: UIButton!
  
    var selectRadio = UIImage.init(named: "icons8-unchecked-radio-button-filled-50.png");
    
    var unselectRadio = UIImage.init(named: "icons8-unchecked-radio-button-50.png")
    
    @IBOutlet weak var SearchAddress: UIButton!
    
    let validatesTextField = validations()
    
    
  //  let searchController = UISearchController(searchResultsController: nil)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
      
        
       UserFlag_button.addTarget(self, action:#selector(UserButton(_:)), for: UIControlEvents.touchUpInside)
     
        isselect1 = false
        isselect2 = false
        st = false
        UserFlag_button.setImage(unselectRadio, for: .normal)
        
       CompanyFlag_button.addTarget(self, action:#selector(CompanyButton(_:)), for: UIControlEvents.touchUpInside)

        
        initSwipe(.right)
        close_button.addTarget(self, action: #selector(close_Action(sender:)), for: .touchUpInside)
        
        self.searchView.isHidden = true
        self.tableview.isHidden = true
 
        self.initializeTextFields()
        self.searchView.addSubview(tableview)
        self.searchView.addSubview(close_button)
        
        SearchAddress.addTarget(self, action:#selector(openMap(sender:)),for:UIControlEvents.touchUpInside)
        self.frameview
            .addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapgesturef(gesture:))))
        

        checkBoxButton.addTarget(self, action: #selector(checkBoxAction(sender:)), for: UIControlEvents.touchUpInside)
        ischecked = false
        registerButton.isEnabled = false
        registerButton.alpha = 0.5
        checkBoxButton.setImage(UIImage.init(named: "icons8-unchecked-checkbox-filled-50.png"), for: .normal)

        
        // Do any additional setup after loading the view.
    }
    func close_Action(sender:UIButton!){
    
        self.searchView.isHidden = true
        
    }
    func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .right) {
            tabBarController?.selectedIndex = 0
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
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
    
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height + 40) * (show ? 1 : -1)
        //5
        
        //    UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
        //            self.bottomConstraint.constant += changeInHeight
        //        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func initializeTextFields() {
        
        name.delegate = self
        name.keyboardType = UIKeyboardType.default
        name.tag = 1
        name.becomeFirstResponder()
        
        email.delegate = self
        email.keyboardType = UIKeyboardType.emailAddress
        email.tag = 2
        
        password.delegate = self
        password.keyboardType = UIKeyboardType.default
        password.tag = 3
        
        conformPassword.delegate = self
        conformPassword.keyboardType = UIKeyboardType.default
        password.tag = 4
        
        selectCountry.delegate = self
        selectCountry.keyboardType = UIKeyboardType.default
        selectCountry.tag = 5
        
        selectCity.delegate = self
        selectCity.keyboardType = UIKeyboardType.default
        selectCity.tag = 6
        
        selectStoreType.delegate = self
        selectStoreType.keyboardType = UIKeyboardType.default
        selectStoreType.tag = 7
        
        Address.delegate = self
        Address.keyboardType = UIKeyboardType.default
        Address.tag = 8

        
        mobileno.delegate = self
        mobileno.keyboardType = UIKeyboardType.numbersAndPunctuation
        mobileno.tag = 9
        
       
        
        
        
    }
  
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func fetchCountryLists(){
 
        Alamofire.request(url_string).responseJSON { (responseData) -> Void in

              if((responseData.result.value) != nil) {
               
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                for i in 0..<swiftyJsonVar["country"].count {

                    print(Country(countryData: swiftyJsonVar["country"][i]))
                    let countrynames = Country(countryData: swiftyJsonVar["country"][i])
                    self.countries.append(countrynames)
                }
                    DispatchQueue.main.async(execute: {
                        self.countriess.addObjects(from: self.countries)
                   
                        print(self.countriess)
                     self.ToggleTextfield(value: true)
                        
                })
            }
            
            }
          }

   
    func fetchdata(countryName:String){
        
        print(countryName)
        
        
        let parameters = ["country": countryName];
        let myItemURL1 = "https://eber.elluminatiinc.com/citilist_selectedcountry"
        
        let headers = ["Content-Type":"Application/json"]
        
        Alamofire.request(myItemURL1, method:.post, parameters:parameters, encoding:JSONEncoding.default , headers: headers).responseJSON {
            (responseObject) -> Void in
            
            
            
            if responseObject.result.isSuccess {
                
                let resJson = (responseObject.result.value) as! [String:Any]
                print(resJson["success"]!)
                let succuess = resJson["success"] as! Bool
                if  succuess == false    {
                    
                 
                }
                else{
                    let swiftJsoncity = JSON(responseObject.result.value!)
                    print(swiftJsoncity)
                    for i in 0..<swiftJsoncity["city"].count {
                        let citynames = City(cityData: swiftJsoncity["city"][i])
                        self.cities.append(citynames)
                        
                    }
                    DispatchQueue.main.async(execute: {
                        self.citiess.addObjects(from: self.cities)
                        
                        print(self.cities)
                    self.ToggleTextfield(value: false)
                        
                     
                    })
                    print("error")
                }
                
            }
            
            if responseObject.result.isFailure {
                
                let error: NSError = responseObject.result.error! as NSError
                print(error)
            }
        }
    }

    
    func ToggleTextfield(value:Bool){
        if value == true {
              numberofrow =  self.countries.count
            textfieldChooseName = "countries"
        }
        else{
        numberofrow =    self.cities.count
        textfieldChooseName = "cities"
        }
        self.tableview.reloadData()
        self.searchView.isHidden = false
        self.tableview.isHidden = false
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberofrow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:searchTableViewCell  =   tableView.dequeueReusableCell(withIdentifier: "countrycell", for: indexPath) as! searchTableViewCell
  
        if textfieldChooseName == "countries"{
         
            let myUser  =   self.countries[indexPath.row]
            cell.countrycode_lbl.alpha = 1.0
            cell.countrycode_lbl.text = String(myUser.countryphonecode)
            cell.country_lbl.text  =   myUser.countryname
        }
  
        else if textfieldChooseName == "cities" {
       
            let myUser  =   self.cities[indexPath.row]
            cell.countrycode_lbl.alpha = 0.0
            cell.country_lbl.text = myUser.cityname
        }
        
    else{
        print(cell.country_lbl.text ?? "it's null")
        }
       
        return cell
        
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if textfieldChooseName == "countries"{
        
            let myUser = self.countries[indexPath.row]
        selectCountry.text = myUser.countryname
            countryCode = myUser.countryphonecode
            mobileno.text = countryCode
 
        self.countries.removeAll()
            
        }
     
       else if textfieldChooseName == "cities"{
        
            let myUser = self.cities[indexPath.row]
        selectCity.text = myUser.cityname
        self.cities.removeAll()
        }
       
        
        self.tableview.isHidden = true
        self.searchView.isHidden = true
    
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if textfieldChooseName == "countries"{
            
            let myUser = self.countries[indexPath.row]
            selectCountry.text = myUser.countryname
            countryCode = myUser.countryphonecode
            mobileno.text = countryCode
            
            self.countries.removeAll()
            
        }
            
        else if textfieldChooseName == "cities"{
            
            let myUser = self.cities[indexPath.row]
            selectCity.text = myUser.cityname
            self.cities.removeAll()
        }
        
        
        self.tableview.isHidden = false
        self.searchView.isHidden = false
        
        
    }

    func tapgesturef(gesture:UITapGestureRecognizer){
        self.frameview.endEditing(true)
       
   
        resignFirstResponder()
    }
  
   
    func checkBoxAction(sender: UIButton){
        if ischecked == false {
            
            registerButton.isEnabled = true
            registerButton.alpha = 1.0
            ischecked = true
            checkBoxButton.setImage(UIImage.init(named: "icons8-checked-checkbox-filled-50.png"), for: .normal)
        }
        else if ischecked == true{
            
            registerButton.isEnabled = false
            registerButton.alpha = 0.5
            ischecked = false
            checkBoxButton.setImage(UIImage.init(named: "icons8-unchecked-checkbox-filled-50.png"), for: .normal)
        }
    }
  
   
    
    
    @IBAction func registerAction(_ sender: Any) {
    
        self.validation()
        
    }
    
    func validation(){
    
        let (title,messsage,value) = validatesTextField.validationtextField(name:name.text!, email: email.text!,password:password.text!,conformPassword:conformPassword.text!,selectCountry:selectCountry.text!,selectCity:selectCity.text!,Address:Address.text!,countryCode:countryCode,mobileno:mobileno.text!,selectStoreType:selectStoreType.text!,refferal:st)
        if value == true {
            let signupobject = signup()
          useid = signupobject.singupmethod(nameStr:name.text!, emailStr: email.text!,passwordStr:password.text!,conformPasswordStr:conformPassword.text!,selectCountryStr:selectCountry.text!,selectCityStr:selectCity.text!,AddressStr:Address.text!,selectStoreTypeStr:selectStoreType.text!,mobilenosStr:mobileno.text!,status:st)
            
            print(useid)
            let userDefault = UserDefaults.standard
            userDefault.set(useid, forKey: "id")

            alert(title: title, message: messsage, value: value)
            
            
        }
       
        
    }
 
    func alert(title:String, message:String, value:Bool){
        
        let alertcntrl = UIAlertController.init(title:title, message: message, preferredStyle: .alert)
        
        let alertaction = UIAlertAction.init(title: "ok", style: .default) { (UIAlertAction) in
            
            if value == true {
            
                let loginScreen = LoginViewController()
                loginScreen.id_user = self.useid
                loginScreen.emailString = self.email.text!
                loginScreen.passwordString = self.password.text!
              // self.initSwipe(.left)
                if self.tabBarController?.selectedIndex == 1 {
                    let secondTab = self.tabBarController?.viewControllers?[0] as! LoginViewController
                    secondTab.emailString = self.email.text!
                    secondTab.passwordString = self.password.text!
                    self.tabBarController?.selectedIndex = 0
                }

            }else{
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        alertcntrl.addAction(alertaction)
    
        self.present(alertcntrl, animated: true, completion: nil)
    }



   
    
    
    
    
    
    
    
    
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField == selectCountry {
            self.fetchCountryLists()
                    }
        if textField == selectCity
        {
             fetchdata(countryName:selectCountry.text! )
            
        }else{
                   }
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == selectCountry
        {
          self.selectCountry.text = whitespaceCon.containWhiteSpace(text:selectCountry.text!)
           
            print(self.selectCountry.text!)
        
            
        }
        if textField == selectCity {
            selectCity.text = whitespaceCon.containWhiteSpace(text:selectCity.text!)
     
            
            //self.tablview?.isHidden = true
        }
        
        if textField.endEditing(true){
            self.resignFirstResponder()
            self.tableview.isHidden = true
            self.searchView.isHidden = true
        }
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool
    {
        // We ignore any change that doesn't add characters to the text field.
        // These changes are things like character deletions and cuts, as well
        // as moving the insertion point.
        //
        // We still return true to allow the change to take place.
        if string.characters.count == 0 {
            return true
        }
        
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {
  
            // Allow only upper- and lower-case vowels in this field,
        // and limit its contents to a maximum of 6 characters.
        case name:
            return /*prospectiveText.containsOnlyCharactersIn("aeiouAEIOU") &&*/
                prospectiveText.characters.count <= 100
   
            // Allow any characters EXCEPT upper- and lower-case vowels in this field,
        // and limit its contents to a maximum of 8 characters.
        case email:
            return /*prospectiveText.doesNotContainCharactersIn("aeiouAEIOU") &&*/
                prospectiveText.characters.count <= 50
//        case countryCode:
//            return  prospectiveText.containsOnlyCharactersIn("+0123456789") &&
//                prospectiveText.characters.count <= 4
//            // Allow only digits in this field,
//        // and limit its contents to a maximum of 3 characters.
      
        case mobileno:


            
            return prospectiveText.containsOnlyCharactersIn("+0123456789") && prospectiveText.characters.count <= (countryCode.characters.count + 10)
        
        default:
            return true
        }
        
    }
    // Dismiss the keyboard when the user taps the "Return" key or its equivalent
    // while editing a text field.

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        
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
   
    func button(sender:UIButton){
        

        self.tableview.isHidden = true
        self.searchView.isHidden = true
    }
 


    //map button click it is ---open map
    
    func openMap(sender:UIButton){
        
        let mapScreen = self.storyboard?.instantiateViewController(withIdentifier: "map")as! mapViewController
     Address.text = ""
        self.navigationController?.pushViewController(mapScreen, animated: true)

        
    }
  
    
  @IBAction func saveName(segue: UIStoryboardSegue) {
        let mapController = segue.source as! mapViewController
        Address.text = mapController.addressString
    

    }
  

    @IBAction func CompanyButton(_ sender: Any) {
        if isselect2 == false{
            isselect2 = true
            st = true
            CompanyFlag_button.setImage(selectRadio, for: .normal)
            UserFlag_button.setImage(unselectRadio, for: .normal);isselect1 = false
        }
    }
    
    @IBAction func UserButton(_ sender: Any) {
        if isselect1 == false {
            isselect1 = true
            st = false
            UserFlag_button.setImage(selectRadio, for: .normal)
            CompanyFlag_button.setImage(unselectRadio, for: .normal);isselect2 = false
        }
    }
    
    
}

extension String {
    
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) != nil
    }
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = Locale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    
    
    
    
    
    
}

