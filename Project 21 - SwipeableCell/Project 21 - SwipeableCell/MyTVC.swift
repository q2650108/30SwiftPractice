//
//  MyTVC.swift
//  Project 21 - SwipeableCell
//
//  Created by SHUN on 1/11/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MyTVC: UITableViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
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
    // MARK:       Table view data source
    //=============================//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTVCell
        
        cell.viewTitle.backgroundColor = indexPath.row % 2 == 0 ? UIColor.blue.withAlphaComponent(0.5) : UIColor.red.withAlphaComponent(0.5)
        
        cell.labelTitle.text = "Label_\(indexPath.row)"
        
        return cell
    }
    
    //==============================//
    // MARK:       Table view Delegate
    //=============================//
    
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == UITableViewCellEditingStyle.delete {
    //            print("delete")
    //        }
    //    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") {
            action, index in
            print("more button tapped")
            
            guard let cell = tableView.cellForRow(at: indexPath) as?  MyTVCell , let text = cell.labelTitle.text else{
                return
            }
            
            let activityViewController = UIActivityViewController(activityItems: [ text ], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        more.backgroundColor = UIColor.lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") {
            action, index in
            print("favorite button tapped")
            
            let imageView = UIImageView( frame: CGRect(x: 0, y: 0, width: 10, height: 10) )
            imageView.image = UIImage(named: "2")
            imageView.contentMode = .scaleAspectFit
            
            guard let image = imageView.image else{
                return
            }
            
            let activityViewController = UIActivityViewController(activityItems: [ image ], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        favorite.backgroundColor = UIColor.orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") {
            action, index in
            print("share button tapped")
        }
        share.backgroundColor = UIColor.blue
        
        return [share, favorite, more]
    }
    
    
}
