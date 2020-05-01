//
//  Product.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation

//Product change var -> let
class Product {
    
    let group: String
    var name: String
    let description: String
    let cost: Int
    let volume: Int
    let add: [Add]
    let avalible: Bool
    let imageUrl: String
    
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
    
    init(product: Product) {
        self.group = product.group
        self.name = product.name
        self.description = product.description
        self.cost = product.cost
        self.volume = product.volume
        self.add = product.add
        self.avalible = product.avalible
        self.imageUrl = ""
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
