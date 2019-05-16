//
//  tablesViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 29/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class tablesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var url_string = "https://eber.elluminatiinc.com/country_list/"
    var countrynm : String!

    var countriess = NSMutableArray()
    
    var countries : [Country] = []
    var citiess = NSMutableArray()
    var cities : [City] = []
    
    var numberofrow = Int()
    
    var textfieldChooseName = String()
    
    var whitespaceCon = WhiteSpaceC()
    var mobilenos = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//        self.tableview.reloadData()
//        self.searchView.isHidden = false
//        self.tableview.isHidden = false
        
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
//            selectCountry.text = myUser.countryname
//            countryCode = myUser.countryphonecode
//            mobileno.text = countryCode
            
            self.countries.removeAll()
            
        }
            
        else if textfieldChooseName == "cities"{
            
            let myUser = self.cities[indexPath.row]
       //     selectCity.text = myUser.cityname
            self.cities.removeAll()
        }
        
        
//        self.tableview.isHidden = true
//        self.searchView.isHidden = true
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if textfieldChooseName == "countries"{
            
            let myUser = self.countries[indexPath.row]
//            selectCountry.text = myUser.countryname
//            countryCode = myUser.countryphonecode
//            mobileno.text = countryCode
            
            self.countries.removeAll()
            
        }
            
        else if textfieldChooseName == "cities"{
            
            let myUser = self.cities[indexPath.row]
     //       selectCity.text = myUser.cityname
            self.cities.removeAll()
        }
        
        
//        self.tableview.isHidden = false
//        self.searchView.isHidden = false
        
        
    }


   
}
