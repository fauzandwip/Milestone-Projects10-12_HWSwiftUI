//
//  Users.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 01/07/23.
//

import CoreData
import Foundation

class Users: ObservableObject {
    var allUsers = [User]()
    
    let url = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func loadData(moc: NSManagedObjectContext) async {
        guard let url = URL(string: self.url) else {
            print("Failed to load url.")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            let decoded = try jsonDecoder.decode([User].self, from: data)
            
            DispatchQueue.main.async {
                self.allUsers = decoded
            }
            
            Task {
                await MainActor.run {
                    self.updateCache(moc: moc)
                }
            }
            
        } catch {
            print("Invalid data, \(error.localizedDescription)")
        }
    }
    
    func updateCache(moc: NSManagedObjectContext) {
        for user in allUsers {
            let cachedUser = CachedUser(context: moc)
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ", ")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToCachedFriends(cachedFriend)
            }
        }
        
        try? moc.save()
    }
}
