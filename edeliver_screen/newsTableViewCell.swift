//
//  newsTableViewCell.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 06/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class newsTableViewCell: UITableViewCell {

    @IBOutlet weak var newssubtitle: UILabel!
    @IBOutlet weak var newstitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
