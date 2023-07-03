//
//  UsersListApp.swift
//  UsersList
//
//  Created by Fauzan Dwi Prasetyo on 01/07/23.
//

import SwiftUI

@main
struct UsersListApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
