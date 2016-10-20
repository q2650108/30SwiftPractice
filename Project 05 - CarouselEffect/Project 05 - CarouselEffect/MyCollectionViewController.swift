//
//  MyCollectionViewController.swift
//  Project 05 - CarouselEffect
//
//  Created by SHUN on 10/20/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MyCollectionViewController:UICollectionViewController {

    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let reuseIdentifier = "myCell"
    
    private let testData : [ ( imageNamed: String , title: String ) ] = [ ( "a" , "Apple"       )  ,
                                                                          ( "b" , "Bird"        )  ,
                                                                          ( "c" , "Cup"         )  ,
                                                                          ( "d" , "Duck"        )  ,
                                                                          ( "e" , "Elephant"    )  ,
                                                                          ( "f" , "Fox"         )  ,
                                                                          ( "g" , "Giraffe"     )  ]
    
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
        
        // Register cell classes
        //self.collectionView!.registerClass(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
 
        print("testData.count: \(testData.count)")
        // Do any additional setup after loading the view.
        
        
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
    // MARK:      UICollectionViewDataSource
    //=============================//
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return testData.count * 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
    
        
       cell.imageView?.image = UIImage(named: testData[indexPath.row % testData.count ].imageNamed)
        cell.labelTitle?.text = "\(indexPath.row ) _ " + testData[indexPath.row  % testData.count ].title
        
        
        // Configure the cell
    
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return CGSizeMake( self.view.frame.width / 3  - 10 , self.view.frame.width /  3 - 10  )
    }
    
    
    //==============================//
    // MARK:      UICollectionViewDelegate
    //=============================//

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
