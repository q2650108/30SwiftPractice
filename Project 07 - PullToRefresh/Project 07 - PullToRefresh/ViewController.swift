//
//  ViewController.swift
//  Project 07 - PullToRefresh
//
//  Created by SHUN on 11/10/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private let dataArray : [ String ] = [ "🌲" , "😂" , "🌞" , "🐶" , "🌂" ]
    
    private var labelsArray : [ UILabel ] = [ UILabel ]()
    
    private var currentIndex : Int = 0
    
    private var isAnimating : Bool = false
    
    private var isCanAnimate1 : Bool {
        get {
            return self.currentIndex < self.labelsArray.count
        }
    }
    
    private var refreshControl: UIRefreshControl!
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
        initRefreshControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit{
        print("\(self.dynamicType) deinit")
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        //        refreshControl.backgroundColor = UIColor.redColor()
        //        refreshControl.tintColor = UIColor.yellowColor()
        tableView.addSubview(refreshControl)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RefreshContentsVC")
        
        /// add label into the Array
        for view in vc.view.subviews[0].subviews {
            labelsArray.append(view as! UILabel)
        }
        
        vc.view.frame = refreshControl.frame
        refreshControl.addSubview(vc.view)
    }
    
    private func animateRefreshStep1(){
        isAnimating = true
        
        UIView.animateWithDuration(0.35, animations: {
            (finished) -> Void in
            
            self.getLabel().transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.getLabel().textColor = self.getRandomColor()
            
            }, completion: {
                (finished) -> Void in
                UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.getLabel().transform = CGAffineTransformIdentity
                    self.getLabel().textColor = UIColor.blackColor()
                    
                    }, completion: { (finished) -> Void in
                        self.currentIndex += 1
                        
                        if self.isCanAnimate1 {
                            self.animateRefreshStep1()
                        }
                        else {
                            self.animateRefreshStep2()
                        }
                })
                
                
        })
        
    }
    
    private func animateRefreshStep2(){
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.labelsArray[0].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[1].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[2].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[3].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[4].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.labelsArray[5].transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            }, completion: { (finished) -> Void in
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.labelsArray[0].transform = CGAffineTransformIdentity
                    self.labelsArray[1].transform = CGAffineTransformIdentity
                    self.labelsArray[2].transform = CGAffineTransformIdentity
                    self.labelsArray[3].transform = CGAffineTransformIdentity
                    self.labelsArray[4].transform = CGAffineTransformIdentity
                    self.labelsArray[5].transform = CGAffineTransformIdentity
                    
                    self.refreshControl.endRefreshing()
                    
                    }, completion: { (finished) -> Void in
                        
                        if self.refreshControl.refreshing {
                            self.currentIndex = 0
                            self.animateRefreshStep1()
                        }
                        else {
                            self.isAnimating = false
                            self.currentIndex = 0
                            for i in 0 ..< self.labelsArray.count {
                                self.labelsArray[i].textColor = UIColor.blackColor()
                                self.labelsArray[i].transform = CGAffineTransformIdentity
                            }
                            
                        }
                })
        })
        
    }
    
    private func getLabel() -> UILabel {
        return labelsArray[currentIndex]
    }
    
    private func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
}


//==============================//
// MARK:      UIScrollViewDelegate
//=============================//
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        if refreshControl.refreshing {
            if !isAnimating {
                animateRefreshStep1()
            }
        }
    }
}



//==============================//
// MARK:      UITableViewDelegate
//=============================//
extension ViewController : UITableViewDelegate {
    
    
    
}




//==============================//
// MARK:      UITableViewDataSource
//=============================//
extension ViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.dataArray[indexPath.row]
        
        
        
        return cell
        
    }
    
}





