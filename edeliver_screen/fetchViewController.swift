//
//  fetchViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 04/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class fetchViewController: UIViewController {
    var stringname = String()
var stringdesc = String()
    @IBOutlet weak var TopicTitle: UILabel!
    @IBOutlet weak var detailtextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TopicTitle.text = stringname
        detailtextview.text = stringdesc
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
