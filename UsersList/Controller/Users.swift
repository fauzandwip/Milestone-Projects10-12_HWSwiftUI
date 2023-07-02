//
//  Users.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 01/07/23.
//

import Foundation

class Users: ObservableObject {
    @Published var allUsers = [User]()
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Failed to load url.")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonDecoder = JSONDecoder()
            
            let decoded = try jsonDecoder.decode([User].self, from: data)
            
            DispatchQueue.main.async {
                self.allUsers = decoded
            }
            
        } catch {
            print("Invalid data, \(error.localizedDescription)")
        }
    }
    
    func find(userID: String) -> User? {
        return allUsers.first(where: { $0.id == userID })
    }
}
