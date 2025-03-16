//
//  TasksView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 10/2/25.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [Tasks]
    @State var showAddTask = false
    @State var checkBox = false
    @Bindable var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            if category.tasks.isEmpty {
                Spacer()
                ContentUnavailableView {
                    Label("No Tasks", systemImage: "list.bullet.rectangle")
                } description: {
                    Text("You don't have any tasks saved yet.")
                } actions: {
                    Button("Add Task") {
                        showAddTask = true
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel("Add a new task")
                    .accessibilityHint("Opens a form to add a new task")
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("No Tasks. You don't have any tasks saved yet.")
                .accessibilityRemoveTraits(.isImage)
                Spacer()
            } else {
                List {
                    ForEach(category.tasks) { task in
                        TaskRowView(task: task)
                    }
                    .onDelete { index in
                        deleteTask(at: index)
                    }
                }
            }
        }
        
        .navigationTitle(category.name)
        //MARK: Toolbar
        .toolbar {
            Button("Add Task", systemImage: "plus") {
                showAddTask = true
            }
            .disabled(tasks.isEmpty)
        }
        //MARK: Sheet Add Category
        .sheet(isPresented: $showAddTask) {
            AddTaskView(category: category)
                .presentationDetents([.medium])
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = category.tasks[index]
            modelContext.delete(task)
        }
        try? modelContext.save()
    }
    
}

#Preview {
    TasksView(category: Category(name: "Deporte", iconName: "house"))
}
