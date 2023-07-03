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
    @NSManaged public var origin: CachedUser?
    
    public var wrappedID: String {
        id ?? "Unknwon ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknwon Name"
    }

}

extension CachedFriend : Identifiable {

}
