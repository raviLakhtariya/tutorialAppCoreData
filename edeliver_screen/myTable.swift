//
//  myTable.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 21/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class myTable: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    var dataSourceArray  =   [Country](){
        didSet{
            reloadData()
        }
        
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:searchTableViewCell  =   tableView.dequeueReusableCell(withIdentifier: "countrycell", for: indexPath) as! searchTableViewCell
        
        let myUser  =   self.dataSourceArray[indexPath.row]
        
        cell.country_lbl.text  =   myUser.countryname
        
        
        
        return cell
        
    }
    
    


 

}
