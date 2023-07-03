//
//  CachedFriend+CoreDataProperties.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 03/07/23.
//
//

import Foundation
import CoreData


extension CachedFriend {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?
    
    public var wrappedID: String {
        id ?? "Unknwon ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknwon Name"
    }
}

// MARK: Generated accessors for user
extension CachedFriend {
    
    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)
    
    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)
    
    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)
    
    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)
    
}

extension CachedFriend : Identifiable {
    
}
