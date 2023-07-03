//
//  ContentView.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 01/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var users = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.allUsers, id: \.id) { user in
                    ZStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 3) {
                                Circle()
                                    .frame(width: 6)
                                .foregroundColor(user.isActive ? .green : .red)
                                
                                Text(user.isActive ? "Active" : "Inactive")
                                    .font(.system(size:9))
                                    .foregroundColor(user.isActive ? .primary : .secondary)
                            }
                        }
                        
                        NavigationLink {
                            DetailView(users: users, user: user)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                }
            }
            .task {
                if users.allUsers.isEmpty {
                    await users.loadData()
                }
            }
            .navigationTitle("Users List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
