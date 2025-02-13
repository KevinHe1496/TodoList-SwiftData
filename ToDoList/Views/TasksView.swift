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
        List {
            ForEach(category.tasks) { task in
//                Text(task.title)
                TaskRowView(task: task)
            }
            .onDelete { index in
                deleteTask(at: index)
            }
        }
        .navigationTitle(category.name)
        //MARK: Toolbar
        .toolbar {
            Button("Add Task", systemImage: "plus") {
                showAddTask = true
            }
        }
        //MARK: Sheet Add Category
        .sheet(isPresented: $showAddTask) {
            AddTaskView(category: category)
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
    TasksView(category: Category(name: "Deporte"))
}
