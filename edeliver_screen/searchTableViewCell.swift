//
//  searchTableViewCell.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 21/03/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var countrycode_lbl: UILabel!
    @IBOutlet weak var country_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
