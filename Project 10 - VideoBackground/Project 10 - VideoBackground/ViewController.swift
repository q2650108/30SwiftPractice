//
//  ViewController.swift
//  Project 10 - VideoBackground
//
//  Created by SHUN on 11/21/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import AVKit
import AVFoundation
import UIKit

class ViewController: UIViewController  {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var playerLayer : AVPlayerLayer!
    
    private let videoArray : [ String ] = [ "Time" , "Sea" , "Beach"]
    
    private var duration : Float = 0.0
    
    private var isEditingSlider = false
    
    private var currentPlayIndex : Int?
    
    private var timeObserver : AnyObject!
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var viewVideo: UIView!
    /// Video List
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewProgressBar: UIView!
    
    @IBOutlet weak var sliderProgressBar: UISlider!
    @IBOutlet weak var labelToolBarValue: UILabel!
    
    @IBOutlet weak var labelCurentTime: UILabel!
    
    @IBOutlet weak var labelTotalTime: UILabel!
    
    @IBOutlet weak var buttonPre: UIButton!
    
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var buttonStop: UIButton!
    
    @IBOutlet weak var buttonPlay: UIButton!
    
    @IBOutlet weak var buttonPause: UIButton!
    
    @IBOutlet weak var buttonVolumePlus: UIButton!
    
    @IBOutlet weak var buttonVolumeMinus: UIButton!
    
    @IBOutlet weak var buttonSecPlus: UIButton!
    
    @IBOutlet weak var buttonSecMinus: UIButton!
    
    @IBOutlet weak var buttonSpeak: UIButton!
    
    @IBOutlet weak var buttonMute: UIButton!
    
    @IBOutlet weak var buttonFullScreen: UIButton!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func sliderProgresBarValueChanged(sender: UISlider) {
        guard let _ = playerLayer?.player else {
            return
        }
        
        seekTime( Float( sender.value ) )
        
        let targetTime = Int64( sender.value ) == 0 ? 1 : Int64( sender.value )
        
        playVideo(targetTime)
    }
    
    @IBAction func buttonNextTouchUpInside(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        self.currentPlayIndex! += 1
        playVideo( videoArray[ self.currentPlayIndex! % self.videoArray.count ] )
    }
    
    @IBAction func buttonPreTouchUpInside(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        self.currentPlayIndex! -= 1
        playVideo( videoArray[ self.currentPlayIndex! % self.videoArray.count ] )
    }
    
    @IBAction func buttonPlayTouchUpInSide(sender: AnyObject) {
        guard let player = playerLayer?.player else {
            return
        }
        
        player.rate = 1
        
        setPlayControl(true)
    }
    
    @IBAction func buttonPauseTouchUpInSide(sender: AnyObject) {
        guard let player = playerLayer?.player else {
            return
        }
        
        player.rate = 0
        
        setPlayControl(false)
    }
    
    @IBAction func buttonStopTouchUpInSide(sender: AnyObject) {
        initVideo()
        
        self.playerLayer = nil
        self.currentPlayIndex = nil
        self.buttonPre.hidden = false
        self.buttonNext.hidden = false
        self.buttonPlay.hidden = false
        self.buttonPause.hidden = true
        self.buttonSpeak.hidden = false
        self.buttonMute.hidden = true
        self.labelCurentTime.text = "0:00"
        self.labelToolBarValue.alpha = 0
        self.labelTotalTime.text = "0:00"
        self.sliderProgressBar.value = 0
    }
    
    @IBAction func buttonMuteTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        
        setVolumeControl(true)
        self.playerLayer.player!.volume = 1
        animateLabel( self.playerLayer.player!.volume )
    }
    
    @IBAction func buttonSpeakTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        
        setVolumeControl(false)
        self.playerLayer.player!.volume = 0
        animateLabel( self.playerLayer.player!.volume )
    }
    
    @IBAction func buttonVolumePlusTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        setVolumeControl(true)
        
        let newRate = self.playerLayer.player!.volume + 0.1
        self.playerLayer.player!.volume = newRate > 1 ? 1 : newRate
        animateLabel( self.playerLayer.player!.volume )
    }
    
    @IBAction func buttonVolumeMinusTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        setVolumeControl(true)
        
        let newRate = self.playerLayer.player!.volume - 0.1
        self.playerLayer.player!.volume = newRate < 0 ? 0 : newRate
        animateLabel( self.playerLayer.player!.volume )
    }
    
    
    @IBAction func buttonSecPlusTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }

        let targetTime = self.sliderProgressBar.value + 100 * 0.1
        seekTime(targetTime )
        
        let newRate =  targetTime > duration ? duration : targetTime
        playVideo(Int64(newRate))
        
    }
    
    @IBAction func buttonSecMinusTouchUpInSide(sender: AnyObject) {
        guard let _ = playerLayer?.player else {
            return
        }
        
        let targetTime = self.sliderProgressBar.value  -  100 * 0.1
        seekTime(targetTime )
        
        let newRate =  targetTime < 0 ? 0 : targetTime
        playVideo(Int64(newRate))
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    deinit{
        if playerLayer != nil {
            playerLayer.player?.removeObserver(self, forKeyPath: "currentItem")
            playerLayer.player?.removeTimeObserver(self.timeObserver)
            self.timeObserver = nil
        }
        print("\(self.dynamicType) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
        
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
    
    private func initValue(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        checkMoveControl()
        setPlayControl(false)
        setVolumeControl(true)
        self.labelToolBarValue.alpha = 0
    }
    
    /// When Play the new one , need to initial Setting
    private func initVideo(){
        if playerLayer != nil {
            playerLayer.player?.removeObserver(self, forKeyPath: "currentItem")
            playerLayer.player?.removeTimeObserver(self.timeObserver)
            self.timeObserver = nil
        }
        self.viewVideo.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        
        self.isEditingSlider = false
    }
    
    /// play Video by Video Name
    /// - parameters:
    ///   - videoName :
    private func playVideo( videoName : String ) {
        initVideo()
        checkMoveControl()
        setPlayControl(true)
        setVolumeControl(true)
        
        //定义一个视频文件路径
        let filePath = NSBundle.mainBundle().pathForResource(videoName, ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(URL: videoURL)
        //设置大小和位置（全屏）
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = viewVideo.bounds
        
        /// add observer to get Duration when video initial
        let _observOption:NSKeyValueObservingOptions = NSKeyValueObservingOptions([.New,.Old,.Initial])
        playerLayer.player?.addObserver(self, forKeyPath: "currentItem", options: _observOption, context: nil)
        
        playVideo(1)
    }
    
    /// play Video by specific time
    /// - parameters:
    ///   - startTime:
    private func playVideo( startTime : Int64 ){
        let player = self.playerLayer.player!
        if self.timeObserver != nil {
            player.removeTimeObserver(self.timeObserver)
            self.timeObserver = nil
        }
        
        self.timeObserver = player.addPeriodicTimeObserverForInterval(CMTimeMake( startTime - 1 <= 0 ? 1 : startTime - 1 , 100), queue: dispatch_get_main_queue()) {
            [unowned self] time in
            
            if self.playerLayer.player?.currentItem?.status == .ReadyToPlay && !self.isEditingSlider{
                
                let timeString = String(format: "%02.2f", CMTimeGetSeconds(time))
                let formatTime = self.getFormatTime( Int( Float(timeString)! ) )
                self.labelCurentTime.text = "\( formatTime.min):\(formatTime.sec)"
                
                self.sliderProgressBar.value =   Float(timeString)!  / self.duration  * 100
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //添加到界面上
            self.viewVideo.layer.addSublayer(self.playerLayer)
            
            /// if Pause Button visible
            if self.buttonPlay.hidden {
                // Play
                player.play()
            }
        })
    }
    
    /// Create the Video Preview
    private func videoSnapshot(filePathLocal: NSString) -> UIImage? {
        
        let vidURL = NSURL(fileURLWithPath:filePathLocal as String)
        let asset = AVURLAsset(URL: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        /// 截图的时候调整到正确的方向
        generator.appliesPreferredTrackTransform = true
        /// * CMTimeMake(a,b) a当前第几帧, b每秒钟多少帧.当前播放时间a/b
        /// * CMTimeMakeWithSeconds(a,b) a当前时间,b每秒钟多少帧.
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImageAtTime(timestamp, actualTime: nil)
            return UIImage(CGImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
    
    /// Label Animation
    private func setLabelAnimation( value : String ){
        self.labelToolBarValue.text = value
    }
    
    /// Format the Sec
    /// - parameters:
    ///   - sec:
    /// - returns:
    ///   - min:
    ///   - sec:
    private func getFormatTime( sec : Int ) -> ( min : Int , sec : Int ) {
        if sec == 0 {
            return ( 0 , 0)
        }
        return ( sec / 60 , sec % 60 )
    }
    
    /// Set the Pre and Next
    private func checkMoveControl(){
        self.buttonPre.hidden = self.currentPlayIndex == 0
        self.buttonNext.hidden = self.currentPlayIndex == videoArray.count * 3 - 1
    }
    
    /// Set the Play and Pause
    /// - parameters:
    ///   - isPlaying : True is Playing
    private func setPlayControl( isPlaying : Bool ){
        self.buttonPause.hidden = !isPlaying
        self.buttonPlay.hidden = isPlaying
    }
    
    /// Set the Speak and Mute
    /// - parameters:
    ///   - isSpeak : True is Speaking
    private func setVolumeControl( isSpeak : Bool ){
        self.buttonSpeak.hidden = !isSpeak
        self.buttonMute.hidden = isSpeak
    }
    
    /// Set label Animation
    /// Fade in and Fade out
    private func animateLabel( value : Float ){
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.labelToolBarValue.layer.removeAllAnimations()
            self.labelToolBarValue.text = "\( Int( value * 10 )  )"
            
            UIView.animateWithDuration( 0.5 , animations: {
                
                self.labelToolBarValue.alpha = 1
                
                }, completion: {
                    (finished) -> Void in
                    UIView.animateWithDuration(0.5, animations: {
                        self.labelToolBarValue.alpha = 0
                    })
            })
        })
    }
    
    /// play to specific time
    private func seekTime( value : Float ){
        guard let player = playerLayer?.player else {
            return
        }
        
        self.isEditingSlider = true
        
        let selectTime = value / 100  * duration
        
        let timeScale = player.currentItem!.asset.duration.timescale
        let time = CMTimeMakeWithSeconds( Double( selectTime ) , timeScale)
        player.seekToTime(time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        
        self.isEditingSlider = false
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    //==============================//
    // MARK:       Observe
    //=============================//
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>){
        if keyPath == "currentItem"{
            if let playerItem = change!["new"] as? AVPlayerItem{
                /// Get Total Duration
                let totalTime = playerItem.asset.duration.value / Int64(playerItem.asset.duration.timescale)
                self.duration = Float(totalTime)
                let formatTime = getFormatTime( Int(totalTime) )
                
                self.labelTotalTime.text  = "\( formatTime.min):\(formatTime.sec)"
            }
        }
    }
    
    
}

//==============================//
// MARK:      UITableViewDataSource
//=============================//
extension ViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count  * 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! MyTableViewCell
        let index = indexPath.row % videoArray.count
        
        cell.labelTitle.text =  "\(indexPath.row + 1). \(videoArray[ index ]) "
        /// remove the image
        cell.imageViewPreview.image = nil
        
        /// Set Border
        cell.imageViewPreview.layer.borderWidth = 1
        cell.imageViewPreview.layer.borderColor = UIColor.whiteColor().CGColor
        cell.imageViewPreview.layer.cornerRadius = 10
        cell.imageViewPreview.clipsToBounds = true
        
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(backgroundQueue, {
            let iamge = self.videoSnapshot( NSBundle.mainBundle().pathForResource( self.videoArray[ index ], ofType: "mp4")! )
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imageViewPreview.image = iamge
            })
        })
        
        return cell
    }
    
}

//==============================//
// MARK:      UITableViewDelegate
//=============================//
extension ViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.height / 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row % videoArray.count
        
        self.currentPlayIndex = indexPath.row
        
        playVideo( videoArray[ index ])
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

