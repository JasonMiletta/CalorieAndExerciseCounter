//
//  MyCell.swift
//  Assignment 5
//
//  Created by Jason Michael Miletta on 2/26/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class MyCell : UITableViewCell, UITextFieldDelegate {
    //attach this delegate to the cell
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    private var item : Item?
    private var delegate: ItemChangedDelegate?
    
    func setup(item: Item, delegate: ItemChangedDelegate?) {
        self.item = item
        nameField.text = item.name
        amountField.text = String(item.amount)
        self.delegate = delegate
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("Ended")
        item?.name = nameField.text!
        item?.amount = Int(amountField.text!)!
        
        if let delegate = self.delegate {
            delegate.itemChanged(item!)
        }

    }
    
}

protocol ItemChangedDelegate {
    func itemEditing(item: Item)
    func itemChanged(item: Item)
}