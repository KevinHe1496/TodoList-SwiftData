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
            VStack {
                if categories.isEmpty {
                    Spacer()
                    ContentUnavailableView {
                        Label("No Categories", systemImage: "list.bullet.rectangle")
                    } description: {
                        Text("You don't have any categories saved yet.")
                    } actions: {
                        Button("Add Category") {
                            showAddCategory = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(categories) { category in
                            
                            NavigationLink {
                                TasksView(category: category)
                            } label: {
                                CategoryRowView(name: category.name, icon: category.iconName)
                            }
                        }
                        .onDelete { index in
                            deleteCategory(at: index)
                        }
                    }
                    .listStyle(.grouped)
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                
                Button("Add Category", systemImage: "plus") {
                    showAddCategory = true
                }
                .disabled(categories.isEmpty)
            }
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView()
            }
//            .background(Color.lightBackground)
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
