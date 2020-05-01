//
//  Group.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

struct Group {
    let name: String
    var avalible: Bool
    
    init(name: String, avalible: Bool) {
        self.name = name
        self.avalible = avalible
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
