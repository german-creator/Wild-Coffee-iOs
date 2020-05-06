//
//  Service.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase


struct Service {
    
    static var sharedInstance = Service()
    
    //    var allGroupList: [Group] = []
    //    var allProductList: [Product] = []
    var baskedtList: [ProductInBasket]?
    
    var ref: DatabaseReference = Database.database().reference()
    //    var testDataBase: [Group]?
    
    //    var test: String?
    
    //    init() {
    //        var add = [Add]()
    //
    //        let option = ["Cow", "Coconut", "Soy"]
    //        let costOption = [0, 80, 80]
    //        add.append(Add(name: "Milk", option: option, costOption: costOption))
    //
    //        let option1 = ["Sugar free", "One spoon", "Two spoon"]
    //
    //        add.append(Add(name: "Sugar", option: option1, costOption: []))
    //
    //
    //        for i in 0...6 {
    //            let group = Group(name: "Group \(i)", avalible: true)
    //            self.allGroupList.append(group)
    //            for j in 0...5 {
    //                let product = Product(group: group.name, name: "Product \(i) \(j)", description: "description", cost: 140, volume: 200, add: add, avalible: true)
    //                self.allProductList.append(product)
    //            }
    //        }
    //
    
    //        ref = Database.database().reference()
    
    //        self.allGroupList = allGroupListFromDatabase
    
    
    //        let group: String
    //        var name: String
    //        let description: String
    //        let cost: Int
    //        let volume: Int
    //        let add: [Add]
    //        let avalible: Bool
    //        let imageUrl: String
    
    
    //        let parameters = [ "group": "Классика", "name": "Американо", "description": "Один эспрессо и вода", "cost": "90", "volume": "150", "add": "", "avalible": "true", "imageUrl": ""]
    //
    //        ref?.child("Products").childByAutoId().setValue(parameters)
    
    
    //                ref?.child("Groups").childByAutoId().setValue(parameters1)
    //                ref?.child("Groups").childByAutoId().setValue(parameters2)
    //                ref?.child("Groups").childByAutoId().setValue(parameters3)
    //                ref?.child("Groups").childByAutoId().setValue(parameters4)
    //                ref?.child("Groups").childByAutoId().setValue(parameters5)
    
    func createClassicProduct() {
        
        let milkOption = ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"]
        
        let smallMilkCostOption = [0, 50, 50, 50, 20]
        let bigMilkCostOption = [0, 80, 80, 80, 40]
        
        let milkAmerikanoOption = ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"]
        let americanoMilkOption = [0, 10, 10, 10, 10]
        
        let sugarOption = ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"]
        let sinamonOption = ["Нет", "С корицей"]
        
        let syropOption = ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"]
        let syropCostOption = [0, 10, 10, 10, 10]
        
        
        let cinnamonOption = ["Нет", "С корицей"]
        
        
        let sugarAdd = Add(name: "Cахар", option: sugarOption, costOption: [])
        let cinamonAdd = Add(name: "Корица", option: sinamonOption, costOption:[])
        let syropAdd = Add(name: "Сироп", option: syropOption, costOption: syropCostOption)
        let amerivanoAdd3 = Add(name: "Молоко", option: milkAmerikanoOption, costOption: americanoMilkOption)
        let smallMilkAdd = Add(name: "Молоко", option: milkOption, costOption: smallMilkCostOption)
        let bigMilkAdd = Add(name: "Молоко", option: milkOption, costOption: bigMilkCostOption)
        
        
        
        let amerikanoAdd = [sugarAdd, cinamonAdd, syropAdd, amerivanoAdd3]
        let smallMilkCoffeeAdd = [sugarAdd, cinamonAdd, syropAdd, smallMilkAdd]
        let bigMilkCoffeeAdd = [sugarAdd, cinamonAdd, syropAdd, bigMilkAdd]
        
        
        
        
        //        let product1 = Product(group: "Классика",
        //                               name: "Американо",
        //                               description: "Классический черный кофе",
        //                               cost: 90,
        //                               volume: 150,
        //                               add: amerikanoAdd,
        //                               avalible: true)
        //
        //        let product2 = Product(group: "Классика",
        //                               name: "Большой американо",
        //                               description: "Большой классический черный кофе",
        //                               cost: 110,
        //                               volume: 300,
        //                               add: amerikanoAdd,
        //                               avalible: true)
        //
        //        let product3 = Product(group: "Классика",
        //                               name: "Капучино",
        //                               description: "Кофе с хорошо вспенненым молоком",
        //                               cost: 110,
        //                               volume: 180,
        //                               add: smallMilkCoffeeAdd,
        //                               avalible: true)
        //
        //
        //        let product4 = Product(group: "Классика",
        //                               name: "Большой капучино",
        //                               description: "Кофе с хорошо вспенненым молоком",
        //                               cost: 140,
        //                               volume: 350,
        //                               add: bigMilkCoffeeAdd,
        //                               avalible: true)
        //
        //        let product5 = Product(group: "Классика",
        //                               name: "Латте",
        //                               description: "Кофе с хорошо вспенненым молоком",
        //                               cost: 120,
        //                               volume: 220,
        //                               add: smallMilkCoffeeAdd,
        //                               avalible: true)
        //
        //
        //        let product6 = Product(group: "Классика",
        //                               name: "Большой латте",
        //                               description: "Кофе с хорошо вспенненым молоком",
        //                               cost: 150,
        //                               volume: 450,
        //                               add: bigMilkCoffeeAdd,
        //                               avalible: true)
        //
        //        let product7 = Product(group: "Классика",
        //                               name: "Флэт уйат",
        //                               description: "Напиток на двойном эспрессо с добавлением небольшого количества молока",
        //                               cost: 120,
        //                               volume: 170,
        //                               add: smallMilkCoffeeAdd,
        //                               avalible: true)
        //
        //
        //        return [product1, product2, product3, product4, product5, product6, product7]
        //
        
        
        //    }
        
    }
    
}
