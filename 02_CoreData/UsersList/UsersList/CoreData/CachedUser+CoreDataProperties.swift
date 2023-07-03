//
//  CachedUser+CoreDataProperties.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 03/07/23.
//
//

import Foundation
import CoreData


extension CachedUser {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }
    
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var cachedFriends: NSSet?
    
    public var wrappedID: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "No Information"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: String {
        tags ?? "Tags Not Found"
    }
    
    public var friendsArray: [CachedFriend] {
        let set = cachedFriends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for cachedFriends
extension CachedUser {
    
    @objc(addCachedFriendsObject:)
    @NSManaged public func addToCachedFriends(_ value: CachedFriend)
    
    @objc(removeCachedFriendsObject:)
    @NSManaged public func removeFromCachedFriends(_ value: CachedFriend)
    
    @objc(addCachedFriends:)
    @NSManaged public func addToCachedFriends(_ values: NSSet)
    
    @objc(removeCachedFriends:)
    @NSManaged public func removeFromCachedFriends(_ values: NSSet)
    
}

extension CachedUser : Identifiable {
    
}
