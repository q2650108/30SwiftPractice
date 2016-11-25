//
//  MyTableVC.swift
//  Project 11 - ClearTableViewCell
//
//  Created by SHUN on 11/25/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyTableVC: UITableViewController {
   //==============================//
    // MARK:     Pirvate Property
    //=============================//
     private var dataArray = ["Read 3 article on Medium", "Cleanup bedroom", "Go for a run", "Hit the gym", "Build another swift project", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom"]
    
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
    
        
    deinit{
        print("\(self.dynamicType) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    /// get background Color
    private func getBackGroundColor(index: Int) -> UIColor {
        
        let g : CGFloat = 255 / CGFloat( dataArray.count - 1 ) * CGFloat( index )
        return UIColor(red: 255/255, green: g / 255 , blue: 0/255, alpha: 1.0)
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    //==============================//
    // MARK:     UITableViewDelegate
    //=============================//
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("willDisplayCell")
        cell.backgroundColor =  getBackGroundColor(indexPath.row)
        
    }
    
    //==============================//
    // MARK:     UITableViewDataSource
    //=============================//
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyTableVCell
        cell.labelTitle.text = dataArray[indexPath.row]
        return cell
        
    }
    
    

}

