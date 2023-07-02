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
                    NavigationLink {
                        Text("Detail View")
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .task {
                await users.loadData()
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
