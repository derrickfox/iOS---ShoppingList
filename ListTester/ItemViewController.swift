//
//  ItemViewController.swift
//  ListTester
//
//  Created by Derrick Fox on 3/26/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {

    @IBOutlet weak var textFieldItem: UITextField! = nil
    @IBOutlet weak var textFieldQuantity: UITextField! = nil
    @IBOutlet weak var textFieldInfo: UITextField! = nil
    
    var item: String = ""
    var quantity: String = ""
    var info: String = ""
    
    var existingItem: NSManagedObject!
    
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contxt)
        
        if (existingItem != nil) {
            existingItem.setValue(textFieldItem.text as String, forKey: "item")
            existingItem.setValue(textFieldQuantity.text as String, forKey: "quantity")
            existingItem.setValue(textFieldInfo.text as String, forKey: "info")
        } else {
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: contxt)
            
            newItem.item = textFieldItem.text
            newItem.quantity = textFieldQuantity.text
            newItem.info = textFieldInfo.text
            
            println(newItem.item)
            println(newItem)
        }
        
        contxt.save(nil)
        
        self.navigationController?.popToRootViewControllerAnimated(true)

        println("Button pressed")
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        println("View loaded")
        
        if (existingItem != nil) {
            textFieldItem.text = item
            textFieldQuantity.text = quantity
            textFieldInfo.text = info
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
