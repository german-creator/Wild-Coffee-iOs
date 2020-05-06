//
//  OrderCell.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import SwipeCellKit


class OrderCell: SwipeTableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subLabel1: UILabel!
    @IBOutlet weak var subLabel2: UILabel!
    @IBOutlet weak var subLabel3: UILabel!
    @IBOutlet weak var subLabel4: UILabel!
    @IBOutlet weak var imageForProduct: UIImageView!
    
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


