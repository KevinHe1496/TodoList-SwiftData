//
//  ContentView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 9/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @State var showAddCategory = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    NavigationLink(category.name) {
                        TasksView(category: category)
                    }
                }
                .onDelete { index in
                    deleteCategory(at: index)
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
    
    private func deleteCategory(at offsets: IndexSet) {
        for index in offsets {
            let catogorySelected = categories[index]
            modelContext.delete(catogorySelected)
        }
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
