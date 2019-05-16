//
//  showPostsViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 10/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class showPostsViewController: UIViewController {
    var fetchJobArray : [Posts] = []
    var resultdatafetchcompany : [Company] = []
    var resultdatafetchUser : [User] = []
    var strPostId = Int16()
    var userId = Int16()
    var postNameStr = String()
    var postDescStr = String()
    @IBOutlet weak var postAdderName: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var postName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
postName.text = postNameStr
        postDescription.text = postDescStr
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
