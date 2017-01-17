//
//  MainTVC.swift
//  Project 25 - UIViewBasicAnimation
//
//  Created by SHUN on 1/16/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    let itemList : [String] =  [ "Position" , "Flip" , "Opacity" , "Color" , "Scale" , "Rotation" ]
    
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
    // MARK:      Navigation
    //=============================//
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.title = sender as? String
    }
    
    
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    //==============================//
    // MARK:      Table view data source
    //=============================//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = itemList[indexPath.row]
        
        return cell
    }
    
    //==============================//
    // MARK:      Table view data Delegate
    //=============================//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var identifier = ""
        var sender = ""
        
        if itemList[indexPath.row] == "Opacity" {
            identifier = "Animation"
            sender = "Opacity"
            
        }else if itemList[indexPath.row] == "Color" {
            identifier = "Animation"
            sender = "Color"
            
        }else if itemList[indexPath.row] == "Scale" {
            identifier = "Animation"
            sender = "Scale"
            
        }else if itemList[indexPath.row] == "Rotation" {
            identifier = "Animation"
            sender = "Rotation"
            
        }else{
            identifier = "\(itemList[indexPath.row])"
            sender = "\(itemList[indexPath.row])"
        }
        
        self.performSegue(withIdentifier: "show\(identifier)", sender: sender )
    }
    
    
    
    
}
