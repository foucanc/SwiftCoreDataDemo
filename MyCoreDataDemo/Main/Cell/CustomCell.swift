//
//  CustomCell.swift
//  MyCoreDataDemo
//
//  Created by Christophe Foucan on 07/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
