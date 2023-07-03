//
//  DetailView.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 02/07/23.
//

import SwiftUI

struct RowDetailView: View {
    var header: String
    var text: String
    
    var body: some View {
        Section {
            Text(text)
        } header: {
            Text(header)
                .padding(.top, -18)
        }
    }
}

struct FriendView: View {
    @ObservedObject var users: Users
    var friend: Friend
    
    var body: some View {
        NavigationLink {
            if let foundFriend = self.users.find(userID: friend.id) {
                DetailView(users: users, user: foundFriend)
            } else {
                Text("Friend Not Found")
            }
        } label: {
            HStack {
                Text(friend.name)
            }
        }
    }
}

struct DetailView: View {
    init(users: Users, user: User) {
        self.users = users
        self.user = user
        
        UITableView.appearance().sectionFooterHeight = 0
    }
    
    @ObservedObject var users: Users
    var user: User
    
    var body: some View {
//                NavigationView {
        List {
            RowDetailView(header: "Name", text: user.name)
            RowDetailView(header: "Status", text: user.isActive ? "Active" : "Inactive")
            RowDetailView(header: "Age", text: String(user.age))
            RowDetailView(header: "Company", text: user.company)
            RowDetailView(header: "Email", text: user.email)
            RowDetailView(header: "Address", text: user.address)
            RowDetailView(header: "About", text: user.about)
            RowDetailView(header: "Registered", text: getDate())
            RowDetailView(header: "Tags", text: getTags())
            Section(header: Text("Friends")) {
                ForEach(user.friends, id: \.id) { friend in
                    FriendView(users: users, friend: friend)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        //        }
    }
    
    func getTags() -> String {
        return user.tags.joined(separator: ", ")
    }
    
    func getDate() -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        let isoDate = isoDateFormatter.date(from: user.registered)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: isoDate)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let jack = User(id: "id", isActive: true, name: "Jack Sparrow", age: 42, company: "company", email: "@jack", address: "111, Harbor", about: "Captain", registered: "2015-11-10T01:47:18-00:00", tags: ["tag", "tag"], friends: [Friend(id: "Bar", name: "Barbosa"), Friend(id: "Spar", name: "Sparrow")])
    
    static var previews: some View {
        DetailView(users: Users(), user: jack)
    }
}
