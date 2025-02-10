//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Kevin Heredia on 9/2/25.
//
import SwiftData
import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Category.self)
    }
}
