//
//  MasterTVC.swift
//  Project 28 - SpotlightSearch
//
//  Created by SHUN on 1/25/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices


class MasterTVC: UITableViewController {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    private var moviesInfo : NSArray?
    
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
        
        loadMoviesInfo()
        setupSearchableContent()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo {
                let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as! String
                let selectedMovieIndex = Int(selectedMovie.components(separatedBy: ".").last!)
                
               
                self.tableView.selectRow(at:  IndexPath(row: selectedMovieIndex!, section: 0) , animated: true, scrollPosition: UITableViewScrollPosition.middle)
                
 
                performSegue(withIdentifier: "showDetail", sender: self)
            }
        }
    }
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        
        guard let array = moviesInfo else {
            return
        }
        
        for i in 0 ... (array.count - 1) {
            
            guard let movie = array[i] as? [String: String] else {
                return
            }
            
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            
            //set the title
            searchableItemAttributeSet.title = movie["Title"]!
            
            //set the image
            let imagePathParts = movie["Image"]!.components(separatedBy: ".")
            let fileNmae = imagePathParts[0]
            let fileNmaeExtension = imagePathParts[1]
            
            searchableItemAttributeSet.thumbnailURL = Bundle.main.url(forResource: fileNmae , withExtension: fileNmaeExtension )
            
            // Set the description.
            searchableItemAttributeSet.contentDescription = movie["Description"]!
            
            var keywords = [String]()
            let movieCategories = movie["Category"]!.components(separatedBy: ", ")
            for movieCategory in movieCategories {
                keywords.append(movieCategory)
            }
            
            let stars = movie["Stars"]!.components(separatedBy: ", ")
            for star in stars {
                keywords.append(star)
            }
            
            searchableItemAttributeSet.keywords = keywords
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.q2650108.SpotIt.\(i)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
            
            searchableItems.append(searchableItem)
            
            CSSearchableIndex.default().indexSearchableItems(searchableItems) {
                (error) -> Void in
                
                if error != nil {
                    print(error?.localizedDescription ?? " ")
                }
            }
        }
        
        
    }
    
    private func initValue(){
        
        
    }
    
    private func loadMoviesInfo() {
        if let path = Bundle.main.path(forResource: "MoviesData", ofType: "plist") , let pathArray = NSArray(contentsOfFile: path){
            
            moviesInfo = pathArray
        }
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
        guard let list = moviesInfo else {
            return 0
        }
        
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTVCell
        
        guard let data = moviesInfo?[indexPath.row] as? [ String : String ] else {
            return UITableViewCell()
        }
        
        cell.labelTitle.text = data["Title"]!
        cell.labelDesc.text = data["Description"]!
        cell.labelRating.text = data["Rating"]!
        cell.labelRating.layer.cornerRadius = cell.labelRating.frame.width / 2
        cell.labelRating.layer.masksToBounds = true
        
        
        cell.imageViewTitle.image = UIImage(named: data["Image"]!)
        
        
        
        return cell
    }
    
    //==============================//
    // MARK:      Table view delegate
    //=============================//
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    //==============================//
    // MARK:      Navigation
    //=============================//
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? DetailVC , let SelectedIndex = tableView.indexPathForSelectedRow?.row  , let data = moviesInfo?[ SelectedIndex ] as? [ String : String ] else {
            return
        }
        vc.setData(list: data)
        
    }
    
}
