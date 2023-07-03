//
//  ContentView.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 01/07/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var cachedUsers: FetchedResults<CachedUser>
    
    @StateObject private var users = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUsers, id: \.id) { cachedUser in
                    ZStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(cachedUser.wrappedName)
                                Text(cachedUser.wrappedEmail)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 3) {
                                Circle()
                                    .frame(width: 6)
                                    .foregroundColor(cachedUser.isActive ? .green : .red)
                                
                                Text(cachedUser.isActive ? "Active" : "Inactive")
                                    .font(.system(size:9))
                                    .foregroundColor(cachedUser.isActive ? .primary : .secondary)
                            }
                        }
                        
                        NavigationLink {
                            DetailView(cachedUser: cachedUser)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                }
            }
            .onAppear {
                Task {
                    await users.loadData(moc: moc)
                }
                
                // delete cachedUsers data
//                for cachedUser in cachedUsers {
//                    moc.delete(cachedUser)
//                    try? moc.save()
//                }
            }
            .navigationTitle("Users List")
        }
    }
}
