//
//  companyjobTableViewCell.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class companyjobTableViewCell: UITableViewCell {

    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var locationA: UILabel!
    @IBOutlet weak var RequExp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
