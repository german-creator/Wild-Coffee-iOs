//
//  CardCell.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit


protocol CardCellProtocol {
    func onClickCell (indexPath: IndexPath)
}

class CardCell: UITableViewCell {
        
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: CardCellProtocol?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.addTarget(self, action: #selector(buttonClick), for: .touchDown)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        delegate?.onClickCell(indexPath: indexPath!)
    }
        
}
