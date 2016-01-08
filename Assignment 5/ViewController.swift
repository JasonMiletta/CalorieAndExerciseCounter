//
//  ViewController.swift
//  Assignment 5
//
//  Created by Jason Michael Miletta on 2/26/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//
// TODO Fix cell editing.
// TODO Fix Exercise table not showing

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ItemChangedDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allowanceCalorieCount: UILabel!
    @IBOutlet weak var foodCalorieCount: UILabel!
    @IBOutlet weak var exerciseCalorieCount: UILabel!
    @IBOutlet weak var remainingCalorieCount: UILabel!

    private var food = [Item(name: "food 1", amount: 1000)]
    private var exercise =  [Item(name: "exercise 1", amount: 32)]
    private var isEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //V Causes App to crash once keyboardWillShow Selector is hit -> "Invalid selector"
        /*
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
        
        func keyboardWillShow(notification: NSNotification) {
            if let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let height = Int(frame.CGRectValue().height)
                
                let insets = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(height), right: 0)
                self.tableView.contentInset = insets
                self.tableView.scrollIndicatorInsets = insets
            }
        }
        
        func keyboardWillHide(notificiation: NSNotification) {
            let insets = UIEdgeInsetsZero
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }*/
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionInTableView(tableView: UITableView) -> Int{
        //Food and Excercise
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Food" : "Exercise"
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        print("\(section): \(food.count), \(exercise.count)")
        return section == 0 ? food.count : exercise.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = indexPath.section == 0
            ? food[indexPath.row]
            : exercise[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MyCell
        
        cell.setup(item, delegate: self)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        return proposedDestinationIndexPath
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let item : Item = food[sourceIndexPath.row]
        food.removeAtIndex(sourceIndexPath.row)
        food.insert(item, atIndex: destinationIndexPath.row)
    
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
       
        if editingStyle == UITableViewCellEditingStyle.Delete{
            food.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
        
        
    }
    
    @IBAction func onEditClick(sender: UIButton) {
        //modify backing data first (arrays)
        //self.tableView.insertRowsAtIndexPaths
        if isEditing == true{
            sender.setTitle("Edit", forState: .Normal)
            self.tableView?.setEditing(false, animated: false)
            isEditing = false
        }
        else{
            sender.setTitle("Done", forState: .Normal)
            self.tableView?.setEditing(true, animated: false)
            isEditing = true
        }
        self.tableView.reloadData()
    }
    
    @IBAction func onAddFoodClick(sender: UIButton) {
        food.append(Item(name: "food Item", amount: 100))
        self.tableView.reloadData()
        updateCount()
    }
    
    @IBAction func onAddExerciseClick(sender: UIButton) {
        exercise.append(Item(name: "exercise Item", amount: 100))
        self.tableView.reloadData()
        updateCount()
    }
    
    func itemChanged(item: Item) {
        updateCount()
    }
    
    func itemEditing(item: Item) {
        
    }
    
    private func updateCount() {
        var foodCalories: Int = 0
        for item in food { foodCalories += item.amount}
        foodCalorieCount.text = String(foodCalories)
        
        var exerciseCalories: Int = 0
        for item in exercise { exerciseCalories += item.amount}
        exerciseCalorieCount.text = String(exerciseCalories)
        
        remainingCalorieCount.text = String(2000 - foodCalories + exerciseCalories)
        
    }

}

