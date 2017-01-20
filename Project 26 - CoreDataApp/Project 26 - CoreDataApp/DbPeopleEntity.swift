//
//  DbPeopleEntity.swift
//  Project 26 - CoreDataApp
//
//  Created by SHUN on 1/18/17.
//  Copyright © 2017 q2650108. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DbPeopleEntity  : DBUTL {
    
    //==============================//
    // MARK:      Like
    //=============================//
    
    //    func like( contain : String ) -> [PeopleEntity] {
    //
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: PeopleEntity.self) )
    //        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", contain)
    //
    //        return super.excute(fetchRequest: fetchRequest) as! [PeopleEntity]
    //    }
    
    //==============================//
    // MARK:      Select
    //=============================//
    func select( name : String ) -> [PeopleEntity] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: PeopleEntity.self) )
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        return super.query(fetchRequest: fetchRequest) as! [PeopleEntity]
    }
    
    func selectAll( ) -> [PeopleEntity] {
        return super.selectAll(type: PeopleEntity.self)
    }
    
    //==============================//
    // MARK:      Insert
    //=============================//
    func insert( name : String   ) -> Bool {
        
        let context = getContext()
        
        let dbEntity = getManagedObject( context : context , type: PeopleEntity.self)
        print(dbEntity)
        
        dbEntity.name = name
        
        return super.saveContext(context: context)

    }
    
    //==============================//
    // MARK:      Update
    //=============================//
    
    func update( oldName : String , newName : String ) -> Bool {
        
        let context = getContext()
        
        let willUpdatePeopleEntityList = self.select(name: oldName)
        
        print( " oldName: \(oldName) ,  newName: \(newName)  , count: \(willUpdatePeopleEntityList.count)")
        
        for record in willUpdatePeopleEntityList {
            record.name = newName
        }
        
        return super.saveContext(context: context)
    }
    
    //==============================//
    // MARK:      Delete
    //=============================//
    func delete( name : String ) -> Bool {
        let context = getContext()
        
        let willDeletePeopleEntityList = self.select(name: name)
        print( "name: \(name), count: \(willDeletePeopleEntityList.count)")
        
        for record in willDeletePeopleEntityList {
            context.delete(record)
        }
        
        return super.saveContext(context: context)
        
    }
    
    
}
