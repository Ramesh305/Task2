//
//  PersistanceData.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit
import CoreData
class PersistanceData{
    
    private init(){
        
    }
    
    static var shared = PersistanceData()
    
    static var context:NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    static var persistentContainer: NSPersistentCloudKitContainer = {
        
           let container = NSPersistentCloudKitContainer(name: "Task")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
    
    
static func saveContext () {
    print("save")
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
}
