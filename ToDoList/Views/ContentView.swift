//
//  ContentView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 9/2/25.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @State var showAddCategory = false
    @State var searchText = ""
    
    var filteredCategories: [Category] {
        if searchText.isEmpty {
            categories
        } else {
            categories.filter { category in
                category.name.localizedStandardContains(searchText)
            }
        }
    }
    
    
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
                        .accessibilityLabel("Add a new category")
                        .accessibilityHint("Opens a form to add a new category")
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("No Categories. You don't have any categories saved yet.")
                    .accessibilityRemoveTraits(.isImage)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(filteredCategories, id: \.id) { category in
                            
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
                    .presentationDetents([.medium])
            }
            .searchable(text: $searchText)
            .onAppear {
                notificationRequest()
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
    
    private func notificationRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
