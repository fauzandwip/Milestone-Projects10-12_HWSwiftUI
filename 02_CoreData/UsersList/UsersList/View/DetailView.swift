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
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    var cachedFriend: CachedFriend
    
    var body: some View {
        NavigationLink {
            if let foundFriend = self.cachedUsers.first(where: { $0.wrappedID == cachedFriend.wrappedID }) {
                DetailView(cachedUser: foundFriend)
            } else {
                Text("Friend Not Found")
            }
        } label: {
            HStack {
                Text(cachedFriend.wrappedName)
            }
        }
    }
}

struct DetailView: View {
    let cachedUser: CachedUser
    
    var body: some View {
        List {
            RowDetailView(header: "Name", text: cachedUser.wrappedName)
            RowDetailView(header: "Status", text: cachedUser.isActive ? "Active" : "Inactive")
            RowDetailView(header: "Age", text: String(cachedUser.age))
            RowDetailView(header: "Company", text: cachedUser.wrappedCompany)
            RowDetailView(header: "Email", text: cachedUser.wrappedEmail)
            RowDetailView(header: "Address", text: cachedUser.wrappedAddress)
            RowDetailView(header: "About", text: cachedUser.wrappedAbout)
            RowDetailView(header: "Registered", text: cachedUser.wrappedRegistered.formatted(
                date: .abbreviated,
                time: .omitted))
            RowDetailView(header: "Tags", text: cachedUser.wrappedTags)
            Section(header: Text("Friends")) {
                ForEach(cachedUser.friendsArray, id: \.id) { cachedFriend in
                    FriendView(cachedFriend: cachedFriend)
                }
            }
        }
        .navigationTitle(cachedUser.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
