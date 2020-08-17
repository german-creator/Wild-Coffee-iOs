//
//  Product.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import Firebase

//Product change var -> let
class Product {
    
    let group: String
    var name: String
    let description: String
    let cost: Int
    let volume: Int
    let add: [Add]
    let avalible: Bool
    var imageUrl: String
    
    init(group: String, name: String, description: String, cost: Int, volume: Int, add: [Add], avalible: Bool) {
        self.group = group
        self.name = name
        self.description = description
        self.cost = cost
        self.volume = volume
        self.add = add
        self.avalible = avalible
        self.imageUrl = ""
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: Any]
        
        
        self.group = snapshotValue["group"] as! String
        self.name = snapshotValue["name"] as! String
        self.description = snapshotValue["description"] as! String
        self.cost = Int(truncating: snapshotValue["cost"] as! NSNumber)
        self.volume = Int(truncating: snapshotValue["volume"] as! NSNumber)
        
        
        var add: [Add] = []
        let addSnapshotName = snapshotValue["addName"] as! [String]
        for i in 0...addSnapshotName.count - 1 {
            let option = snapshotValue["addOption\(i)"] as! [String]
            
            let cost: [Int]
            if let a = snapshotValue["addCostOption\(i)"] {
                cost = (a as! NSMutableArray) as! [Int]
            } else {
                cost = []
            }
            
            add.append(Add(name: addSnapshotName[i], option: option, costOption: cost))
        }
        self.add = add
    
        self.avalible = snapshotValue["avalible"] as! Bool
        self.imageUrl = snapshotValue["imageUrl"] as! String
        
      }
    
    
    
    init(product: Product) {
        self.group = product.group
        self.name = product.name
        self.description = product.description
        self.cost = product.cost
        self.volume = product.volume
        self.add = product.add
        self.avalible = product.avalible
        self.imageUrl = product.imageUrl
    }
    
    init() {
        self.group = "Group 1"
        self.name = "Name"
        self.description = "Description"
        self.cost = 150
        self.volume = 20
        var add = [Add]()
        let option = ["Cow", "Coconut", "Soy"]
        let costOption = [0, 80, 80]
        add.append(Add(name: "Milk", option: option, costOption: costOption))
        let option1 = ["Sugar free", "One spoon", "Two spoon"]
        add.append(Add(name: "Sugar", option: option1, costOption: []))
        self.add = add
        self.avalible = true
        self.imageUrl = ""
    }
    
    func getTestProductList() -> [Product] {
        var productList: [Product] = []
        for i in 1...5 {
            let product = Product ()
            product.name = product.name + " \(i)"
            productList.append(product)
        }
        return productList
    }
    
    func getTestProductListGroup2() -> [Product] {
        var productList: [Product] = []
        for i in 1...5 {
            let product = Product ()
            product.name = product.name + " \(i)"
            productList.append(product)
        }
        return productList
    }
}
