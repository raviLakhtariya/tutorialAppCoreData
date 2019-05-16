//
//  showdataViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 06/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class showdataViewController: UIViewController,UIWebViewDelegate {
    var link : String = String()
    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.myWebView.delegate = self
     
       print(link)
    let  urllink = "https://www.apple.com/pr/library/2016/04/26Apple-Reports-Second-Quarter-Results.html?sr=hotnews.rss"
          let url = NSURL.init(string: urllink)
        let request: NSURLRequest = NSURLRequest(url: url as! URL)
       myWebView.loadRequest(request as URLRequest)
        

       
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
