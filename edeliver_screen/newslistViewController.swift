//
//  newslistViewController.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 06/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class newslistViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,XMLParserDelegate{

    @IBOutlet weak var barbuton: UIBarButtonItem!
    @IBOutlet weak var tablview: UITableView!
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var link1 = NSMutableString()
    var descriptsion = NSMutableString()
    var date = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barbuton.target = revealViewController()
        barbuton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.beginParsing()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
        parser.delegate = self
        parser.parse()
        
    tablview.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            link1 = NSMutableString()
            link1 = ""
            descriptsion = NSMutableString()
            descriptsion = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !link1.isEqual(nil) {
                elements.setObject(link1, forKey: "link" as NSCopying)
            }
            if !description.isEqual(nil) {
                elements.setObject(descriptsion, forKey: "description" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "title") {
            title1.append(string)
        } else if element.isEqual(to: "pubDate") {
            date.append(string)
            
        }else if element.isEqual(to: "link"){
            link1.append(string)
            
        }else if element.isEqual(to: "description"){
            descriptsion.append(string)
        }
    }
    
    //Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "news")as! newsTableViewCell
        
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?[0] as! UITableViewCell as! newsTableViewCell;
        }
        
        cell.newstitle?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.newssubtitle?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "date") as! NSString as String
    
        return cell as UITableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let show = self.storyboard?.instantiateViewController(withIdentifier: "showdata")as! showdataViewController
        show.link = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "link") as! NSString as String//((posts.object(at: indexPath.row) as AnyObject).value(forKey: "link") as! NSString) as String as String
        
        self.navigationController?.pushViewController(show, animated: true)
    }
    @IBAction func newslistView(segue: UIStoryboardSegue)
    {
        let showdatas = segue.source as! showdataViewController
    }
}
