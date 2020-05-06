//
//  Group.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase

struct Group {
    let name: String
    var avalible: Bool
    
    init(name: String, avalible: Bool) {
        self.name = name
        self.avalible = avalible
    }
    
    init(snapshot: DataSnapshot) {
         let snapshotValue = snapshot.value as! [String: Any]
         self.name = snapshotValue["name"] as! String
         self.avalible = snapshotValue["avalible"] as! Bool
    }
    
    func getTestGroupList() -> [Group] {
        var groupList: [Group] = []
        for i in 1...5 {
            let group = Group (name: "Group \(i)", avalible: true)
            groupList.append(group)
        }
        return groupList
        
    }
}


extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
}
