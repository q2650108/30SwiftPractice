//
//  APIRequestWikiFace.swift
//  Project 30 - WikiFace
//
//  Created by SHUN on 2/2/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit

class APIRequestWikiFace : NSObject {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    fileprivate var personName : String = ""
    
    fileprivate var pixelSize : Int = 0
    
    weak internal var delegate: APIDelegate? = nil
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init(  delegate : APIDelegate , name : String , size : CGSize ) {
        if let encodingName =  name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            personName = encodingName
        }
        
        self.delegate = delegate
        
        self.pixelSize = Int( max( size.width , size.height ) ) * 2
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
}

extension APIRequestWikiFace : APIProtocol {
    
    func start() {
        
        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(personName)&prop=pageimages&format=json&pithumbsize=\(pixelSize)")
        
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data : Data? , response : URLResponse?  , error : Error?) -> Void in
            if let error = error {
                self.delegate?.APIWikiFace!(returnCode: .RequestError, message : error.localizedDescription ,  returnData: nil)
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    guard let entity = APIWikiFaceParser(dic: json).parse() else {
                        self.delegate?.APIWikiFace!(returnCode: .ParseJSONError , message : ""  ,  returnData: nil)
                        return
                    }
                    
                    self.delegate?.APIWikiFace!(returnCode: .Success , message : ""  ,  returnData: entity )
                    
                }catch let error as NSError{
                    self.delegate?.APIWikiFace!(returnCode: .JSONSerializationError, message : error.localizedDescription ,  returnData: nil)
                }
            }
        })
        
        APIRequest(delegate: delegate , sessionDataTask : ( task : task , retryTimes : 0 ) ).excute()
    }
    
}
