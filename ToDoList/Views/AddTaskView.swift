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
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Add Task", text: $name)
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let category = Category(name: name)
                        modelContext.insert(category)
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
    AddTaskView()
}
