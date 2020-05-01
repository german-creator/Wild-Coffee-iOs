//
//  ProductInBasket.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation

class ProductInBasket: Product {
    var count: Int
    var selectedAdd: [Int: Int]
    
    init(count: Int, selectedAdd: [Int: Int], product: Product) {
        self.count = count
        self.selectedAdd = selectedAdd
        super.init(product: product)
    }
}
