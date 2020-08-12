//
//  ProductCell.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var imageForProduct: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension UILabel {
    func addCharactersSpacing(spacing: CGFloat, txt: String) {
        let attributedString = NSMutableAttributedString(string: txt)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: txt.count))
        self.attributedText = attributedString
    }
}
