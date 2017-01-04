//
//  MenuTVC.swift
//  Project 16 - SlideMenu
//
//  Created by SHUN on 1/3/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MenuTVC: UITableViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var menuItems = ["Item A", "Item B", "Item C", "Item D", "Item E", "Item F", "Item G" ]
    
    private var currentItem = "Item A"
    
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
        print("\( type(of: self) )  viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\( type(of: self) )  viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\( type(of: self) )  viewDidAppear")
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
    
    func setMenuItem( item : String)  {
        self.currentItem = item
    }
    
    func getMenuItem() -> String {
        return self.currentItem
    }
    
    //==============================//
    // MARK:     Table view data source
    //=============================//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = (menuItems[indexPath.row] == currentItem ) ? UIColor.white : UIColor.lightGray
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let sourceVC = segue.source as? MenuTVC , let destinationVC = segue.destination as? ContenTVC else {
            return
        }
        
        if let selectedRow = sourceVC.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
        
        destinationVC.tableView.reloadData()
        
    }
    
    
}
