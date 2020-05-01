//
//  Add.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation

struct Add {
    let name: String
    let option: [String]
    let costOption: [Int]
    
    init(name: String, option:[String], costOption: [Int]) {
        self.name = name
        self.option = option
        self.costOption = costOption
    }
}
