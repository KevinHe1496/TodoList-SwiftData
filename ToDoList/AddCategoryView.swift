//
//  AddCategoryView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 10/2/25.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Add Category", text: $name)
            }
            .navigationTitle("Add Category")
            .toolbar {
                Button("Save") {
                    let category = Category(name: name)
                    modelContext.insert(category)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddCategoryView()
}
