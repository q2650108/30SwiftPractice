//
//  TableViewController.swift
//  Project 03 - Play Local Video
//
//  Created by SHUN on 10/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //==============================//
    //      Pirvate Property       //
    //=============================//
    
    /// tabel view cell Identifier
    private let cellIdentifier = "cell"
    
    /// Test Data Save in AppDelegate
    private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//

    //==============================//
    // MARK: - Table view
    //=============================//
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return appDelegate.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
        
        // Set the Image View Background
        cell.ImageViewBackground.image =  UIImage(named: appDelegate.data[indexPath.row].imageNamed)
        // Set the Label Title
        cell.LabelTitle.text = appDelegate.data[indexPath.row].title
        // Set the Button Tag
        cell.ButtonPlay.tag = indexPath.row
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
