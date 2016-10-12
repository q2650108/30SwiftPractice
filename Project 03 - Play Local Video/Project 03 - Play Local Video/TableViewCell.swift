//
//  TableViewCell.swift
//  Project 03 - Play Local Video
//
//  Created by SHUN on 10/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import AVKit
import AVFoundation
import UIKit

class TableViewCell: UITableViewCell {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    /// Test Data Save in AppDelegate
    private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    private var player :AVPlayer!
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    /// Image Background
    @IBOutlet weak var ImageViewBackground: UIImageView!
    
    /// Button Play ICON
    @IBOutlet weak var ButtonPlay: UIButton!
    
    /// Label Title
    @IBOutlet weak var LabelTitle: UILabel!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func ButtonPlayTouchUpInside(sender: AnyObject) {
        /// get Selected Tag
        initPlayer(ButtonPlay.tag)
    }
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    deinit{
        removeNSNotificationCenter()
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initPlayer(index:Int){
        /// get root View Controller
        let viewController =  (UIApplication.sharedApplication().keyWindow?.rootViewController)! as UIViewController
        
        /// Find the file Path from copy bundle resources
        let filePath = NSBundle.mainBundle().pathForResource(appDelegate.data[index].title, ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        // Set the AVPlayer by video URL
        player = AVPlayer(URL: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        viewController.presentViewController(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        
        /// Add the Observer For detect the player end
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playerDidFinishPlaying),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem)
    }
    
    private func removeNSNotificationCenter(){
        /// remove the Observer
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    /// detect the player end
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        removeNSNotificationCenter()
    }
    
    
}
