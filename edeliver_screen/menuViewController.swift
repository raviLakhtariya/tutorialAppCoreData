//
//  menuViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 31/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var status = Bool()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var menutableview: UITableView!
    var showList : [String] = []
    var menuList : [String] = ["home","news","posts","createjobs","searchjob","logout"]
    override func viewDidLoad() {
        self.getUserData()
        super.viewDidLoad()
        var image: UIImage = UIImage(named: "minions_PNG84.png")!
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = menuList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
    func getUserData(){
        let pref = UserDefaults.standard
        status =  (pref.object(forKey: "status") as? Bool)!
        
        if status == false {
            
            menuList.remove(at: 3)
            self.menutableview.reloadData()
            
        }else{
            
        }
    }
   

}
