//
//  PersistentStorage.swift
//  UserCoreData
//
//  Created by phonestop on 10/27/22.
//

import Foundation
import CoreData
//Here we are using singelton pattern
//final class cannot be inherrited , method can't be overridden in order to hange the behaviour of it
final class PersistentStorage {
    
    private init(){}
    static let shared = PersistentStorage()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "UserCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support

    func saveContext () {
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
