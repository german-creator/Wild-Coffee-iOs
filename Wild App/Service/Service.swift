//
//  Service.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation

struct Service {
    
    static var sharedInstance = Service()
    
    var allGroupList: [Group] = []
    var allProductList: [Product] = []
    var baskedtList: [ProductInBasket]?
    
    init() {
        var add = [Add]()
        
        let option = ["Cow", "Coconut", "Soy"]
        let costOption = [0, 80, 80]
        add.append(Add(name: "Milk", option: option, costOption: costOption))
        
        let option1 = ["Sugar free", "One spoon", "Two spoon"]
        
        add.append(Add(name: "Sugar", option: option1, costOption: []))
        
        
        for i in 0...5 {
            let group = Group(name: "Group \(i)", avalible: true)
            self.allGroupList.append(group)
            for j in 0...5 {
                let product = Product(group: group.name, name: "Product \(i) \(j)", description: "description", cost: 140, volume: 200, add: add, avalible: true)
                self.allProductList.append(product)
            }
        }
    }
    
}
