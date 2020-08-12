//
//  TableMenuCollectionViewCell.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class TableMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 17
        
    }

}
