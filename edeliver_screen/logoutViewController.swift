//
//  logoutViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class logoutViewController: UIViewController {
    @IBOutlet weak var barButton: UIBarButtonItem!
  
var removedata = saveUserdata()
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
  
   
    @IBAction func logout(_ sender: Any) {
        let value =  self.removedata.removeData()
        

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
