//
//  APIRequest.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit

class APIRequest {
    
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private weak var delegate : APIDelegate? = nil
    
    
    private var taskQueue : [ ( task : URLSessionDataTask , retryTimes : Int ) ] =  [ ( task : URLSessionDataTask , retryTimes : Int ) ]()
    
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
    
    init( delegate : APIDelegate?  , sessionDataTask : ( task : URLSessionDataTask , retryTimes : Int )  ) {
        
        self.delegate = delegate
        
        taskQueue.append(sessionDataTask)
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
    
    func excute() {
        for ( index , element ) in taskQueue.enumerated() {
            
            let taskStatus = element.task.state
            
            if taskStatus != URLSessionTask.State.canceling ||
                taskStatus !=  URLSessionTask.State.completed ||
                taskStatus !=  URLSessionTask.State.running  {
                
                if element.retryTimes >= 0 {
                    element.task.resume()
                    
                    let indexes = taskQueue.index( where : { $0 == element })
                    taskQueue[indexes!].retryTimes -= 1
                }else{
                    /// Wrong retryTimes
                    taskQueue.remove(at: index)
                }
            }
        }
    }
    
    
}
