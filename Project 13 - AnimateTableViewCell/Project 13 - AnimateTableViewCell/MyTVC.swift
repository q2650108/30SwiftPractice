//
//  MyTVC.swift
//  Project 13 - AnimateTableViewCell
//
//  Created by SHUN on 12/8/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyTVC: UITableViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var tableData = ["Personal Life", "Buddy Company", "#30 days Swift Project", "Body movement training", "AppKitchen Studio", "Project Read", "Others" ]
    
    
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
        
        print("\( type(of: self) ) viewDidLoad")
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        animateTable()
        
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
    
    /// 取得 Vch Id Color
    /// - parameters:
    ///   - index:
    /// - returns:
    private func colorforIndex(index: Int) -> UIColor {
        let count = tableData.count * 3
        let r = CGFloat(235 / count *  index ) + 20
        let g = CGFloat(205 / count *  index ) + 50
        return UIColor(red: r / 255 , green: g / 255 , blue: 0.1 , alpha: 1 )
        
    }
    
    private func animateTable() {
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion:{
                (finished: Bool) -> Void in
                UIView.transition(with: cell , duration: 1 , options: .transitionFlipFromTop , animations: nil, completion: nil)
            }
            )
        }
    }
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    //==============================//
    // MARK:      Action Handle
    //=============================//
    
    func editActionHandler( action : UITableViewRowAction , index : IndexPath ){
        self.tableView.setEditing(false, animated: true)
    }
    
    //==============================//
    // MARK:      Table view data source
    //=============================//
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count * 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTVCell
        
        cell.labelContent.text = "( \(indexPath.row) ) - \(tableData[indexPath.row % tableData.count ])"
        
        return cell
    }
    
    //==============================//
    // MARK:      Table View Delegate
    //=============================//
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView willDisplay")
        cell.backgroundColor =  colorforIndex(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView didEndDisplaying")
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default , title: "editAction", handler: editActionHandler)
        editAction.backgroundColor = UIColor.gray
        
        let deleteAction = UITableViewRowAction(style: .destructive , title: "deleteAction", handler: editActionHandler)
        deleteAction.backgroundColor = UIColor.red
        
        
        return [ editAction , deleteAction]
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
}
