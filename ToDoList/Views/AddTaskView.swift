//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 10/2/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    var category: Category
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                TextField("Add Task", text: $name)
                    .accessibilityLabel("Enter a new task")
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let task = Tasks(title: name, createdAt: Date.now, category: category)
                        category.tasks.append(task)
                        try? modelContext.save()
                        dismiss()
                    }
                    .accessibilityLabel("Save task")
                    .accessibilityHint("Saves the new task and returns to the list")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityLabel("Cancel and go back")
                    .accessibilityHint("Discards changes and goes back to the previews screen")
                }
                
            }
        }
    }
}

#Preview {
    AddTaskView(category: Category(name: "asd", iconName: "house"))
}
