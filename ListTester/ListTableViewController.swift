//
//  ListTableViewController.swift
//  ListTester
//
//  Created by Derrick Fox on 3/26/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var myList : Array<AnyObject> = []
    var testerString:String = "Damnit"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "List")
        
        myList = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "update" {
            var selectedItem: NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
            
            let IVC: ItemViewController = segue.destinationViewController as! ItemViewController
            
            IVC.item = selectedItem.valueForKey("item") as! String
            IVC.quantity = selectedItem.valueForKey("quantity") as! String
            IVC.info = selectedItem.valueForKey("info") as! String
            IVC.existingItem = selectedItem
            
            println(testerString)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath?{
            
            var data: NSManagedObject = myList[ip.row] as! NSManagedObject
            cell.textLabel?.text = (data.valueForKeyPath("item") as! String)
            
            var qnt = data.valueForKeyPath("quantity") as! String
            var inf = data.valueForKeyPath("info") as! String
            
            cell.detailTextLabel?.text = "\(qnt) item(s). Info: \(inf)"
        }

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!

        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            if let tv = tableView as UITableView?{
                context.deleteObject(myList[indexPath.row] as! NSManagedObject)
                myList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var error: NSError? = nil
            if !context.save(&error){
                abort()
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
