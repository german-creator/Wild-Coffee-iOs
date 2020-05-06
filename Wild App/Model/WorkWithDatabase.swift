//
//  WorkWithDatabase.swift
//  Wild App
//
//  Created by Герман Иванилов on 03.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase

struct WorkWithDatabase {
    
    static func getAllAvalibleGroup(completionHandler: @escaping ([Group]) -> Void)  {
        
        var allGroupListFromDatabase: [Group] = []
        
        Service.sharedInstance.ref.child("Group").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let group = Group(snapshot: i)
                allGroupListFromDatabase.append(group)
            }
            let result = allGroupListFromDatabase.filter{$0.avalible == true}
            completionHandler(result)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    static func getAllAvalibleProduct(completionHandler: @escaping ([Product]) -> Void)  {
        
        var allProductListFromDatabase: [Product] = []
        
        Service.sharedInstance.ref.child("Products").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let group = Product(snapshot: i)
                allProductListFromDatabase.append(group)
            }
            let result = allProductListFromDatabase.filter{$0.avalible == true}
            completionHandler(result)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    static func addProductToDatabase () {
        
        
//        let milkOption = ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"]
//
//        let smallMilkCostOption = [0, 50, 50, 50, 20]
//        let bigMilkCostOption = [0, 80, 80, 80, 40]
//
//        let milkAmerikanoOption = ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"]
//        let americanoMilkOption = [0, 10, 10, 10, 10]
//
//        let sugarOption = ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"]
//        let sinamonOption = ["Нет", "С корицей"]
//
//        let syropOption = ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"]
//        let syropCostOption = [0, 10, 10, 10, 10]
        
        
//        let cinnamonOption = ["Нет", "С корицей"]
//
//        let sugarAdd = Add(name: "Cахар", option: sugarOption, costOption: [])
//        let cinamonAdd = Add(name: "Корица", option: sinamonOption, costOption:[])
//        let syropAdd = Add(name: "Сироп", option: syropOption, costOption: syropCostOption)
//        let amerivanoAdd3 = Add(name: "Молоко", option: milkAmerikanoOption, costOption: americanoMilkOption)
//        let smallMilkAdd = Add(name: "Молоко", option: milkOption, costOption: smallMilkCostOption)
//        let bigMilkAdd = Add(name: "Молоко", option: milkOption, costOption: bigMilkCostOption)
//
//
//        let amerikanoAdd = [sugarAdd, cinamonAdd, syropAdd, amerivanoAdd3]
//        let smallMilkCoffeeAdd = [sugarAdd, cinamonAdd, syropAdd, smallMilkAdd]
//        let bigMilkCoffeeAdd = [sugarAdd, cinamonAdd, syropAdd, bigMilkAdd]
//
        
        let americano = [ "group": "Классика",
                          "name": "Американо",
                          "description": "Классический черный кофе",
                          "cost": 90,
                          "volume": 150,
                          "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
                          "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                          "addCostOption0" : [],
                          "addOption1" : ["Нет", "С корицей"],
                          "addCostOption1" : [],
                          "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
                          "addCostOption2" : [0, 10, 10, 10, 10],
                          "addOption3" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                          "addCostOption3" : [0, 10, 10, 10, 10],
                          "avalible": true,
                          "imageUrl": ""] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(americano)

        
        let bigAmericano = [ "group": "Классика",
                             "name": "Большой американо",
                             "description": "Большой классический черный кофе",
                             "cost": 110,
                             "volume": 300,
                             "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
                             "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                             "addCostOption0" : [],
                             "addOption1" : ["Нет", "С корицей"],
                             "addCostOption1" : [],
                             "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
                             "addCostOption2" : [0, 10, 10, 10, 10],
                             "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
                             "addCostOption3" : [0, 10, 10, 10, 10],
                             "avalible": true,
                             "imageUrl": ""] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(bigAmericano)

        let capuchino = [ "group": "Классика",
                          "name": "Капучино",
                          "description": "Кофе с хорошо вспенненым молоком",
                          "cost": 110,
                          "volume": 180,
                          "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
                          "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                          "addCostOption0" : [],
                          "addOption1" : ["Нет", "С корицей"],
                          "addCostOption1" : [],
                          "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
                          "addCostOption2" : [0, 10, 10, 10, 10],
                          "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
                          "addCostOption3" : [0, 50, 50, 50, 20],
                          "avalible": true,
                          "imageUrl": ""] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(capuchino)
        
        let bigCapuchino = [ "group": "Классика",
                             "name": "Большой капучино",
                             "description": "Кофе с хорошо вспенненым молоком",
                             "cost": 140,
                             "volume": 350,
                             "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
                             "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                             "addCostOption0" : [],
                             "addOption1" : ["Нет", "С корицей"],
                             "addCostOption1" : [],
                             "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
                             "addCostOption2" : [0, 10, 10, 10, 10],
                             "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
                             "addCostOption3" : [0, 80, 80, 80, 40],
                             "avalible": true,
                             "imageUrl": ""] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(bigCapuchino)

        

        
        
        
      
        
        
        
//        let parameters = [ "group": "Авторские напитки",
//                           "name": "Латте Соленая Карамель",
//                           "description": "Большой латте с добавленим собственного карамельного соуса",
//                           "cost": 170,
//                           "volume": 450,
//                           "addName" : ["Молоко", "Корица"],
//                           "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
//                           "addCostOption0" :[0, 80, 80, 80, 40],
//                           "addOption1" : ["Нет", "С корицей"],
//                           "addCostOption1" : [],
//                           "avalible": "true",
//                           "imageUrl": ""] as [String : Any]
        
//        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(parameters)
        
    }
    
    static func addGroupToDatabase () {
        
        let parameters = [ "name": "Классика",
                           "avalible": true ] as [String : Any]
        
        let parameters1 = [ "name": "Авторские напитки",
                            "avalible": true ] as [String : Any]
        
        let parameters2 = [ "name": "Летнее меню",
                            "avalible": true ] as [String : Any]
        
        let parameters3 = [ "name": "Осеннее меню",
                            "avalible": false ] as [String : Any]
        
        let parameters4 = [ "name": "Зимнее меню",
                            "avalible": false ] as [String : Any]
        
        let parameters5 = [ "name": "Весенее меню",
                            "avalible": false ] as [String : Any]
        
        let parameters6 = [ "name": "Не кофе",
                            "avalible": true ] as [String : Any]
        
        let parameters7 = [ "name": "Альтернатива",
                            "avalible": true ] as [String : Any]
        
        
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters1)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters2)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters3)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters4)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters5)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters6)
        Service.sharedInstance.ref.child("Group").childByAutoId().setValue(parameters7)
        
        
    }
    
    
    
}
