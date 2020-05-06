//
//  Add.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase

struct Add {
    let name: String
    let option: [String]
    let costOption: [Int]
    
    init(name: String, option:[String], costOption: [Int]) {
        self.name = name
        self.option = option
        self.costOption = costOption
    }
    
//    init(snapshot: DataSnapshot) {
//        
//        let snapshotValue = snapshot.value as! [String: Any]
//        
//        self.name = snapshotValue["name"] as! String
//        self.option = snapshotValue["option"] as! [String]
//        self.costOption = snapshotValue["costOprtion"] as! [Int]
//    }
}
