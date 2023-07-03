//
//  DataController.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 03/07/23.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "UsersList")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to laod: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
