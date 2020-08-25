//
//  WorkWithDatabase.swift
//  Wild App
//
//  Created by Герман Иванилов on 03.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase
import Nuke

struct WorkWithDatabase {
    
    static func getAllAvalibleGroup(completionHandler: @escaping ([Group]?, Error?) -> Void)  {
        
        var allGroupListFromDatabase: [Group] = []
        
        Service.sharedInstance.ref.child("Group").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let group = Group(snapshot: i)
                allGroupListFromDatabase.append(group)
            }
            let result = allGroupListFromDatabase.filter{$0.avalible == true}
            completionHandler(result, nil)
            
        }) { (error) in
            completionHandler(nil, error)
        }
        
        
    }
    
    static func getAllAvalibleProduct(completionHandler: @escaping ([Product]) -> Void)  {
        
        var allProductListFromDatabase: [Product] = []
        
        Service.sharedInstance.ref.child("Products").observeSingleEvent(of: .value, with: { (snapshot) in
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let product = Product(snapshot: i)
                allProductListFromDatabase.append(product)
            }
            let result = allProductListFromDatabase.filter{$0.avalible == true}
            completionHandler(result)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func puchOrderToDatabase(order: Order) {
        
        var orderToDatabase: [String : Any] = [ : ]
        
        orderToDatabase["time"] = order.timeTo
        orderToDatabase["comment"] = order.comment
        orderToDatabase["userPhone"] = Auth.auth().currentUser?.phoneNumber
        
        
        
        var productArray: [String] = []
        
        for i in order.products {
            
            var add0: String?
            var add1: String?
            var add2: String?
            var add3: String?
            
            switch i.add.count {
            case 0: break
                
            case 1:
                if i.selectedAdd[0] != 0 {
                    add0 = i.add[0].option[i.selectedAdd[0]!]
                }
            case 2:
                if i.selectedAdd[0] != 0 {
                    add0 = i.add[0].option[i.selectedAdd[0]!]
                }
                if i.selectedAdd[1] != 0 {
                    add1 = i.add[1].option[i.selectedAdd[1]!]
                }
                
            case 3:
                if i.selectedAdd[0] != 0 {
                    add0 = i.add[0].option[i.selectedAdd[0]!]
                }
                if i.selectedAdd[1] != 0 {
                    add1 = i.add[1].option[i.selectedAdd[1]!]
                }
                if i.selectedAdd[2] != 0 {
                    add2 = i.add[2].option[i.selectedAdd[2]!]
                }
            case 4:
                if i.selectedAdd[0] != 0 {
                    add0 = i.add[0].option[i.selectedAdd[0]!]
                }
                if i.selectedAdd[1] != 0 {
                    add1 = i.add[1].option[i.selectedAdd[1]!]
                }
                if i.selectedAdd[2] != 0 {
                    add2 = i.add[2].option[i.selectedAdd[2]!]
                }
                if i.selectedAdd[3] != 0 {
                    add3 = i.add[3].option[i.selectedAdd[3]!]
                }
            default: break
            }
            
            
            let productToOrder = [    i.name,
                                      add0 ?? "",
                                      add1 ?? "",
                                      add2 ?? "",
                                      add3 ?? "",
                                      String(i.count) + " шт",
                                      "\n"]
            
            
            productArray.append(contentsOf: productToOrder)
        }
        
        orderToDatabase ["products"] = productArray
        
        
        FirebaseAuthentication.getCurrentUserName(completionHandler: { (name) in
            orderToDatabase["userName"] = name
            Service.sharedInstance.ref.child("Orders").childByAutoId().setValue(orderToDatabase)
        })
        
        
        
        
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
        
        //        let americano = [ "group": "Классика",
        //                          "name": "Американо",
        //                          "description": "Классический черный кофе",
        //                          "cost": 90,
        //                          "volume": 150,
        //                          "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
        //                          "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                          "addCostOption0" : [],
        //                          "addOption1" : ["Нет", "С корицей"],
        //                          "addCostOption1" : [],
        //                          "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
        //                          "addCostOption2" : [0, 10, 10, 10, 10],
        //                          "addOption3" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
        //                          "addCostOption3" : [0, 10, 10, 10, 10],
        //                          "avalible": true,
        //                          "imageUrl": ""] as [String : Any]
        //
        //        let iceMathca = [ "group": "Летнее меню",
        //                          "name": "Айс Матча",
        //                          "description": "Холодный вариант японского порошкового зелёного чай с молоком",
        //                          "cost": 140,
        //                          "volume": 400,
        //                          "addName" : ["Сахар", "Молоко"],
        //                          "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                          "addCostOption0" : [],
        //                          "addOption1" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
        //                          "addCostOption1" : [0, 10, 10, 10, 10],
        //                          "avalible": true,
        //                          "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%9B%D0%B5%D1%82%D0%BD%D0%B5%D0%B5%20%D0%BC%D0%B5%D0%BD%D1%8E%2F%D0%90%D0%B8%CC%86%D1%81%20%D0%9C%D0%B0%D1%82%D1%87%D0%B0.png?alt=media&token=4b847c62-4e09-4015-bd7f-60d84eefaf16"] as [String : Any]
        //
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(iceMathca)
        
        //
        //        let bigAmericano = [ "group": "Классика",
        //                             "name": "Большой американо",
        //                             "description": "Большой классический черный кофе",
        //                             "cost": 110,
        //                             "volume": 300,
        //                             "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
        //                             "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                             "addCostOption0" : [],
        //                             "addOption1" : ["Нет", "С корицей"],
        //                             "addCostOption1" : [],
        //                             "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
        //                             "addCostOption2" : [0, 10, 10, 10, 10],
        //                             "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
        //                             "addCostOption3" : [0, 10, 10, 10, 10],
        //                             "avalible": true,
        //                             "imageUrl": ""] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(bigAmericano)
        //
        //        let capuchino = [ "group": "Классика",
        //                          "name": "Латте",
        //                          "description": "Мягкий кофе с молоком и небольшой шапочкой из пены",
        //                          "cost": 120,
        //                          "volume": 230,
        //                          "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
        //                          "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                          "addCostOption0" : [],
        //                          "addOption1" : ["Нет", "С корицей"],
        //                          "addCostOption1" : [],
        //                          "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
        //                          "addCostOption2" : [0, 10, 10, 10, 10],
        //                          "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
        //                          "addCostOption3" : [0, 50, 50, 50, 20],
        //                          "avalible": true,
        //                          "imageUrl": ""] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(capuchino)
        //
        //        let bigCapuchino = [ "group": "Классика",
        //                             "name": "Большой латте",
        //                             "description": "Большой стакан любимого всеми напитка",
        //                             "cost": 150,
        //                             "volume": 450,
        //                             "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
        //                             "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                             "addCostOption0" : [],
        //                             "addOption1" : ["Нет", "С корицей"],
        //                             "addCostOption1" : [],
        //                             "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
        //                             "addCostOption2" : [0, 10, 10, 10, 10],
        //                             "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
        //                             "addCostOption3" : [0, 80, 80, 80, 40],
        //                             "avalible": true,
        //                             "imageUrl": ""] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(bigCapuchino)
        //
        //
        //        let flat = [ "group": "Классика",
        //                             "name": "Флэт Уйат",
        //                             "description": "Крепкий кофе с молоком неболшого объема",
        //                             "cost": 130,
        //                             "volume": 180,
        //                             "addName" : ["Сахар", "Корица", "Сироп", "Молоко"],
        //                             "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                             "addCostOption0" : [],
        //                             "addOption1" : ["Нет", "С корицей"],
        //                             "addCostOption1" : [],
        //                             "addOption2" : ["Нет", "Кокосовый сироп", "Шоколадный сироп", "Кокосовый сироп", "Шоколадный сироп"],
        //                             "addCostOption2" : [0, 10, 10, 10, 10],
        //                             "addOption3" : ["Нет", "Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко"],
        //                             "addCostOption3" : [0, 50, 50, 50, 20],
        //                             "avalible": true,
        //                             "imageUrl": ""] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(flat)
        //
        
        
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
        
        
        //        let matcha = [ "group": "Не кофе",
        //                       "name": "Латте Матча",
        //                       "description": "Японский зеленый чай с молоком",
        //                       "cost": 140,
        //                       "volume": 450,
        //                       "addName" : ["Сахар", "Молоко"],
        //                       "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
        //                       "addCostOption0" : [],
        //                       "addOption1" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
        //                       "addCostOption1" : [0, 80, 80, 80, 40],
        //                       "avalible": true,
        //                       "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%9D%D0%B5%20%D0%BA%D0%BE%D1%84%D0%B5%2F%D0%9C%D0%B0%D1%82%D1%87%D0%B0.png?alt=media&token=e8212b14-6673-43db-ab66-06e8ae3bc3fe"] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(matcha)
        
        //        let chocolate = [ "group": "Не кофе",
        //                          "name": "Горячий шоколад",
        //                          "description": "Бельгийский шоколад Callebaut растопленный в молоке",
        //                          "cost": 100,
        //                          "volume": 230,
        //                          "addName" : ["Вкус", "Молоко"],
        //                                  "addOption0" : ["Классический темный", "Апельсиновый", "Малиновый"],
        //                                  "addCostOption0" : [],
        //                                  "addOption1" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
        //                                  "addCostOption1" : [0, 50, 50, 50, 20],
        //                          "avalible": true,
        //                          "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%9D%D0%B5%20%D0%BA%D0%BE%D1%84%D0%B5%2F%D0%93%D0%BE%D1%80%D1%8F%D1%87%D0%B8%D0%B8%CC%86%20%D1%88%D0%BE%D0%BA%D0%BE%D0%BB%D0%B0%D0%B4.png?alt=media&token=f7e06704-6aae-42cb-b2fe-9f35581ea0bd"] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(chocolate)
        //
        //        let bigChocolate = [ "group": "Не кофе",
        //                          "name": "Большой горячий шоколад",
        //                          "description": "450 мл горячего шоколада на ваш выбор",
        //                          "cost": 150,
        //                          "volume": 450,
        //                          "addName" : ["Вкус", "Молоко"],
        //                          "addOption0" : ["Классический темный", "Апельсиновый", "Малиновый"],
        //                          "addCostOption0" : [],
        //                          "addOption1" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
        //                          "addCostOption1" : [0, 80, 80, 80, 40],
        //                          "avalible": true,
        //                          "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%9D%D0%B5%20%D0%BA%D0%BE%D1%84%D0%B5%2F%D0%93%D0%BE%D1%80%D1%8F%D1%87%D0%B8%D0%B8%CC%86%20%D1%88%D0%BE%D0%BA%D0%BE%D0%BB%D0%B0%D0%B4%20%D0%91.png?alt=media&token=f86e2be1-1fa9-455f-b918-fee3d5421240"] as [String : Any]
        //
        //        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(bigChocolate)
        
        
        let vanil = [ "group": "Авторские напитки",
                      "name": "Ванильный Раф",
                      "description": "Классический раф на молоке со сливками и ванильным сахаром",
                      "cost": 180,
                      "volume": 450,
                      "addName" : ["Молоко"],
                      "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                      "addCostOption0" : [0, 80, 80, 80, 40],
                      "avalible": true,
                      "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%92%D0%B0%D0%BD%D0%B8%D0%BB%D1%8C%D0%BD%D1%8B%D0%B8%CC%86%20%D1%80%D0%B0%D1%84.png?alt=media&token=43a22fd1-0e2c-4f22-9bcf-f6ccd88989e8"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(vanil)
        
        let cherry = [ "group": "Авторские напитки",
                       "name": "Вишневый Американо",
                       "description": "Американов  добавлением вишневого джема",
                       "cost": 150,
                       "volume": 300,
                       "addName" : ["Сахар", "Покислее"],
                       "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                       "addCostOption0" : [],
                       "addOption1" : ["Нет", "Да"],
                       "addCostOption1" : [],
                       "avalible": true,
                       "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%92%D0%B8%D1%88%D0%BD%D0%B5%D0%B2%D1%8B%D0%B8%CC%86%20%D0%90%D0%BC%D0%B5%D1%80%D0%B8%D0%BA%D0%B0%D0%BD%D0%BE.png?alt=media&token=d91e4183-77f6-4045-aa58-0d4282fccbc8"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(cherry)
        
        let blackberry = [ "group": "Авторские напитки",
                           "name": "Ежевичный Американо",
                           "description": "Американов  добавлением ежевичного джема собственного приготовления",
                           "cost": 150,
                           "volume": 300,
                           "addName" : ["Сахар", "Покислее"],
                           "addOption0" : ["Нет", "Половина ложки сахара", "Ложка сахара", "Две ложки сахара", "Три ложки сахара"],
                           "addCostOption0" : [],
                           "addOption1" : ["Нет", "Да"],
                           "addCostOption1" : [],
                           "avalible": true,
                           "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%95%D0%B6%D0%B5%D0%B2%D0%B8%D1%87%D0%BD%D1%8B%D0%B8%CC%86%20%D0%90%D0%BC%D0%B5%D1%80%D0%B8%D0%BA%D0%B0%D0%BD%D0%BE.png?alt=media&token=27b9ee18-1995-47a6-b60e-0985d7612817"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(blackberry)
        
        let strawberry = [ "group": "Авторские напитки",
                           "name": "Клубничный Раф",
                           "description": "Раф с добалением клубничного шоколада",
                           "cost": 180,
                           "volume": 450,
                           "addName" : ["Молоко"],
                           "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                           "addCostOption0" : [0, 80, 80, 80, 40],
                           "avalible": true,
                           "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9A%D0%BB%D1%83%D0%B1%D0%BD%D0%B8%D1%87%D0%BD%D1%8B%D0%B8%CC%86%20%D0%A0%D0%B0%D1%84.png?alt=media&token=867c786a-43dc-4696-ab9d-9c678647a656"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(strawberry)
        
        let lavender = [ "group": "Авторские напитки",
                         "name": "Лавандовый Раф",
                         "description": "Цветки лаванда перемолотые с сахаром в классическом рафе",
                         "cost": 180,
                         "volume": 450,
                         "addName" : ["Молоко"],
                         "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                         "addCostOption0" : [0, 80, 80, 80, 40],
                         "avalible": true,
                         "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9B%D0%B0%D0%B2%D0%B0%D0%BD%D0%B4%D0%BE%D0%B2%D1%8B%D0%B8%CC%86%20%D1%80%D0%B0%D1%84.png?alt=media&token=086fc61c-d071-475f-b65d-46c4910a4051"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(lavender)
        
        let nutella = [ "group": "Авторские напитки",
                        "name": "Латте Nutella",
                        "description": "Пара ложек нутеллы разтопленные в большом латте",
                        "cost": 170,
                        "volume": 450,
                        "addName" : ["Молоко"],
                        "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                        "addCostOption0" : [0, 80, 80, 80, 40],
                        "avalible": true,
                        "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9B%D0%B0%D1%82%D1%82%D0%B5%20Nutella.png?alt=media&token=3ba3ebbd-29bc-4aab-8a22-991865b04fa6"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(nutella)
        
        let snickers = [ "group": "Авторские напитки",
                         "name": "Латте Snickers",
                         "description": "Любимый всеми латте с арахисовой халвой и молочным шоколадом",
                         "cost": 170,
                         "volume": 450,
                         "addName" : ["Молоко"],
                         "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                         "addCostOption0" : [0, 80, 80, 80, 40],
                         "avalible": true,
                         "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9B%D0%B0%D1%82%D1%82%D0%B5%20Snickers.png?alt=media&token=a5986c47-ea53-4490-8a56-2acd5ecfc72c"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(snickers)
        
        let mokko = [ "group": "Авторские напитки",
                      "name": "Латте Мокко",
                      "description": "Классический авторский напиток с темным шоколадом",
                      "cost": 170,
                      "volume": 450,
                      "addName" : ["Молоко"],
                      "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                      "addCostOption0" : [0, 80, 80, 80, 40],
                      "avalible": true,
                      "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9B%D0%B0%D1%82%D1%82%D0%B5%20%D0%9C%D0%BE%D0%BA%D0%BA%D0%BE.png?alt=media&token=adfb135a-1be5-42e7-bcb7-c0acdeff1966"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(mokko)
        
        let salt = [ "group": "Авторские напитки",
                     "name": "Латте Соленая Карамель",
                     "description": "Латте с добавлением карамели собственного приготовления",
                     "cost": 170,
                     "volume": 450,
                     "addName" : ["Молоко"],
                     "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                     "addCostOption0" : [0, 80, 80, 80, 40],
                     "avalible": true,
                     "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%9B%D0%B0%D1%82%D1%82%D0%B5%20%D0%A1%D0%BE%D0%BB%D0%B5%D0%BD%D0%B0%D1%8F%20%D0%9A%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D0%BB%D1%8C.png?alt=media&token=0d983f0d-b8ae-4707-b861-d9c176b97c84"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(salt)
        
        let citrus = [ "group": "Авторские напитки",
                       "name": "Цитрусовый раф",
                       "description": "Раф с добавлением сахар из цедры цитрусовых",
                       "cost": 180,
                       "volume": 450,
                       "addName" : ["Молоко"],
                       "addOption0" : ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"],
                       "addCostOption0" : [0, 80, 80, 80, 40],
                       "avalible": true,
                       "imageUrl": "https://firebasestorage.googleapis.com/v0/b/wild-coffee-order.appspot.com/o/%D0%90%D0%B2%D1%82%D0%BE%D1%80%D1%81%D0%BA%D0%B8%D0%B5%20%D0%BD%D0%B0%D0%BF%D0%B8%D1%82%D0%BA%D0%B8%2F%D0%A6%D0%B8%D1%82%D1%80%D1%83%D1%81%D0%BE%D0%B2%D1%8B%D0%B8%CC%86%20%D0%A0%D0%B0%D1%84.png?alt=media&token=a077b49b-d683-43c7-9f69-964b74124665"] as [String : Any]
        
        Service.sharedInstance.ref.child("Products").childByAutoId().setValue(citrus)
        
        
        
        
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
