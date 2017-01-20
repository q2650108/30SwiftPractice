//
//  MainTVC.swift
//  Project 26 - CoreDataApp
//
//  Created by SHUN on 1/17/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController  {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    lazy var listPeopleEntity : [PeopleEntity] = [PeopleEntity]()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var barbuttonAdd: UIBarButtonItem!
    
    @IBOutlet weak var textFieldContent: UITextField!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func barbuttonAdd(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first , let name = textField.text else {
                                            return
                                        }
                                        
                                        
                                        DispatchQueue.global().async {
                                            
                                            if DbPeopleEntity().insert( name : name ){
                                                
                                                self.listPeopleEntity = DbPeopleEntity().selectAll()
                                                /// get List Last Index
                                                let lastIndex = IndexPath(row: self.listPeopleEntity.count - 1 , section: 0)
                                                
                                                DispatchQueue.main.async {
                                                    self.tableView.insertRows(at: [lastIndex], with: .automatic )
                                                }
                                            }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
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
        
        initValue()
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
        
        
        listPeopleEntity  = DbPeopleEntity().selectAll( type : PeopleEntity.self )
        print(listPeopleEntity.count)
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
        return listPeopleEntity.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        cell.textLabel?.text = "\(listPeopleEntity[indexPath.row].name ?? "")"
        print("=== \( listPeopleEntity[indexPath.row].name)")
        
        return cell
    }
    
    
    
    //==============================//
    // MARK:      Table view Delegate
    //=============================//
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(editingStyle)
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            print("delete")
            
            DispatchQueue.global().async {
                
                if DbPeopleEntity().delete( name: self.listPeopleEntity[indexPath.row].name ?? "" ){
                    
                    self.listPeopleEntity.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedValue = self.listPeopleEntity[indexPath.row].name else {
            return
        }
        
        let alert = UIAlertController(title: "Old Name is \"\(selectedValue)\"",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first , let newName = textField.text else {
                                            return
                                        }
                                        
                                        DispatchQueue.global().async {
                                            
                                            if DbPeopleEntity().update(oldName: selectedValue, newName: newName){
                                                
                                                self.listPeopleEntity = DbPeopleEntity().selectAll()
                 
                                                DispatchQueue.main.async {
                                                    self.tableView.reloadData()
                                                }
                                            }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)

        
        
    }
    
    
    //==============================//
    // MARK:     UITextField Delegate
    //=============================//
    
}
