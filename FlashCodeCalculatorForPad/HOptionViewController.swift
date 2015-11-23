//
//  HOptionViewController.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/21/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import UIKit

class HOptionViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        DBCollection.sharedInstance().selectedModel?.clearAllSelection()
    }

    // MARK: - Table view data source

    @IBOutlet var optionTable: UITableView!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("Hoption number is \(DBCollection.sharedInstance().selectedModel!.hoptionList.count)")
        return DBCollection.sharedInstance().selectedModel!.hoptionList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = DBCollection.sharedInstance().selectedModel!.hoptionList[indexPath.row].optionName
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectChanged(tableView, indexPath:indexPath)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath){
        selectChanged(tableView, indexPath:indexPath)
    }
    
    func selectChanged(tableView: UITableView, indexPath: NSIndexPath ){
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell != nil{
            let selectedName = cell?.textLabel.text!
            let option = DBCollection.sharedInstance().selectedModel!.hoptionList.filter(){$0.optionName == selectedName}.first!
            option.isChecked = !option.isChecked
            if option.isChecked{
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else{
                cell?.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        self.navigationItem.title = DBCollection.sharedInstance().getFlashCode()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
