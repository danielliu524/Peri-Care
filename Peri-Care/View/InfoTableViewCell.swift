//
//  InfoTableViewCell.swift
//  Pericare
//
//  Created by Daniel Liu on 9/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var completedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
