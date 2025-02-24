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
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
            }
        }
    }
}

#Preview {
    AddTaskView(category: Category(name: "asd", iconName: "house"))
}
