//
//  yourpostCellTableViewCell.swift
//  edeliver_screen
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class yourpostCellTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var postsubTitle: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
