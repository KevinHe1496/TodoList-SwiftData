//
//  ContentView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 9/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var categories: [Category]
    @State var showAddCategory = false
    @State var category = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    NavigationLink(category.name) {
                        Text(category.name)
                    }
                    
                }
            }
            .navigationTitle("Todo List")
            //MARK: Toolbar
            .toolbar {
                Button("Add Category", systemImage: "plus") {
                    showAddCategory = true
                }
            }
            //MARK: Sheet Add Category
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
