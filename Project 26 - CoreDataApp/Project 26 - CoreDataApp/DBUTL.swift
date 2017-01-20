//
//  DBUTL.swift
//  Project 26 - CoreDataApp
//
//  Created by SHUN on 1/18/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DBUTL {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init() {
        
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    internal func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    internal func saveContext( context : NSManagedObjectContext) -> Bool {
        
        if context.hasChanges {
            // 儲存資料
            do {
                try context.save()
                return true
            } catch let error as NSError {
                print("save error: \(error.userInfo)")
            }
        }
        return false
    }
    
    internal func getManagedObject<T>( context : NSManagedObjectContext , type _ : T.Type) -> T {
        
        let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context)
        return NSManagedObject(entity: entity!, insertInto: context) as! T
    }
    
    internal func query( fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [Any]? {
        
        var searchResults : [Any]?
        
        do {
            //go get the results
            searchResults = try getContext().fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return searchResults
    }
    
    internal func selectAll<T>( type _ : T.Type ) -> [T] {
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self) )
        
        return query(fetchRequest: fetchRequest) as! [T]
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    
    
    
}
