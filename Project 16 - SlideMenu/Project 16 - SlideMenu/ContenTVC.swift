//
//  ContenTVC.swift
//  Project 16 - SlideMenu
//
//  Created by SHUN on 1/3/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit

class ContenTVC : UITableViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    let menuTransitionManager = MenuTransitionManager()
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    func handleMenuTap(){
        self.performSegue(withIdentifier: "showMenu", sender: nil)
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Item A"
        /// Change the navigationBar Color
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        //create a new button
        let button: UIButton = UIButton.init(type: .custom) 
        
        //set image for button
        button.setImage(UIImage(named: "menu-button"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(self.handleMenuTap), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
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
    // MARK:     Table view data source
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(self.title ?? "") - \(indexPath.row) "
        
        return cell
    }
    
    //==============================//
    // MARK:     Navigation
    //=============================//
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
        guard let sourceController = segue.source as? MenuTVC else {
            return
        }
        
        self.title = sourceController.getMenuItem()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard  let menuTVC = segue.destination as? MenuTVC else {
            return
        }
        
        menuTVC.setMenuItem(item: self.title ?? "")
        menuTVC.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
    }
    
}

//==============================//
// MARK:     MenuTransition Manager Delegate
//=============================//
extension ContenTVC : MenuTransitionManagerDelegate {
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
