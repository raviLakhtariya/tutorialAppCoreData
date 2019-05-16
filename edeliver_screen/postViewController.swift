//
//  postViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class postViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var fetchPostsArray : [Posts] = []
    var userdataFetch = saveUserdata()
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    var cid = Int16()
    var cemail = String()
    var cpassword = String()
    var cstatus = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
       barButton.target = revealViewController()
        
        barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
//        view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //

        let std:NSFetchRequest<Posts> = Posts.fetchRequest()
        do{
            self.fetchPostsArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
            print(fetchPostsArray)
            
        } catch{
            print(error.localizedDescription)
        }
        self.tableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return fetchPostsArray.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = self.tableview.dequeueReusableCell(withIdentifier: "postcell") as! postTableViewCell
        
        
        
        
        let stdarrau = fetchPostsArray[indexPath.row]
        
        print(stdarrau)
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "postcell") as! postTableViewCell
        }
        
        
        cell.postTitle.text! = stdarrau.posttitle!
        cell.postDescription.text! = stdarrau.postdescriptions!
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createPostScreen = self.storyboard?.instantiateViewController(withIdentifier: "showposts")as! showPostsViewController
        
        
        let stdary = fetchPostsArray[indexPath.row]
        createPostScreen.strPostId = stdary.postid
        createPostScreen.postNameStr = stdary.posttitle!
        createPostScreen.postDescStr = stdary.postdescriptions!
        
        
        
        
        self.navigationController?.pushViewController(createPostScreen, animated: true)
    }
    func fetchDatas(){
        var (cids,cemails,cpasswords,cstatuss) = userdataFetch.getData()
        self.cid = cids
        self.cemail = cemails
        self.cpassword = cpasswords
        self.cstatus = cstatuss
        
    }

    @IBAction func PostView(segue: UIStoryboardSegue)
    {
        let postviewController = segue.source as! showPostsViewController
    }
}
