//
//  Item.swift
//  Assignment 5
//
//  Created by Jason Michael Miletta on 2/26/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class Item: Equatable {
    
    var name: String
    var amount: Int

    init(name: String, amount: Int) {
        self.name = name
        self.amount = amount
    }
}

func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name && lhs.amount == rhs.amount
}
