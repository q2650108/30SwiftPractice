//
//  AVCaptureViewController.swift
//  Project 04 - SnapChatMenu
//
//  Created by SHUN on 10/19/16.
//  Copyright © 2016 kinpomis. All rights reserved.
//

import UIKit
import AVFoundation

class AVCaptureViewController: UIViewController {
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = AVCaptureSessionPresetHigh
        return s
    }()
    
    private lazy var stillImageOutput : AVCaptureStillImageOutput = {
        let dataOutput = AVCaptureStillImageOutput()
        dataOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        return dataOutput
    }()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview =  AVCaptureVideoPreviewLayer(session: self.session)
        preview.bounds = CGRect(x: 0, y: 0, width: self.viewContent.bounds.width, height: self.viewContent.bounds.height)
        preview.position = CGPoint(x: CGRectGetMidX(self.viewContent.bounds), y: CGRectGetMidY(self.viewContent.bounds))
        preview.videoGravity = AVLayerVideoGravityResize
        return preview
    }()
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValue()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // session Status
        if !session.running {
            self.viewContent.layer.addSublayer(previewLayer)
            
            session.startRunning()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
        session.stopRunning()
        
        for output in session.outputs {
            session.removeOutput(output as? AVCaptureOutput)
        }
        
        for input in session.inputs {
            session.removeInput(input as? AVCaptureInput)
        }
    }
    
    
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        setupCameraSession()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.viewContent.addGestureRecognizer(tapGesture)
        
        getVisualEffectView().alpha = 0
    }
    
    private func setupCameraSession() {
        
        var captureDevice : AVCaptureDevice?
        
        for device: AnyObject in AVCaptureDevice.devices() {
            // Back Camera
            if device.position == AVCaptureDevicePosition.Back {
                captureDevice = device as? AVCaptureDevice
            }
            // Front Camera
            //if caputureDevice.position == AVCaptureDevicePosition.Front {
            //    camera = caputureDevice as? AVCaptureDevice
            //}
        }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            session.beginConfiguration()
            
            if (session.canAddInput(deviceInput) == true) {
                session.addInput(deviceInput)
            }
            
            if session.canAddOutput(stillImageOutput) {
                session.addOutput(stillImageOutput)
            }
            
            
            session.commitConfiguration()
            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
    }
    
    private func getVisualEffectView() -> UIVisualEffectView {
        return visualEffectView
    }
    
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    //==============================//
    // MARK:      Gesture
    //=============================//
    func handleTap(sender: UITapGestureRecognizer){
        
        getVisualEffectView().alpha = 1
        
        /// crate Flash effect
        UIView.animateWithDuration( 0.1 ,  animations: { () -> Void in
            
            self.getVisualEffectView().alpha = 0
        })
        
        
        if let connection:AVCaptureConnection? = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo){
            
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: { (imageDataBuffer, error) -> Void in
                
                // Convert to Jpeg
                //let imageData:NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
                
                // To  UiImage
                //let image:UIImage = UIImage(data: imageData)!
                
                /// save in Album
                //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
                
            })
        }
        
        
    }
    
}


