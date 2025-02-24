//
//  TaskRowView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 11/2/25.
//

import SwiftUI

struct TaskRowView: View {
    @Environment(\.modelContext) var modelContext
    var task: Tasks

    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                if task.isCompleted {
                    filledReminderLabel
                } else {
                    emptyReminderLabel
                }
            }
            .frame(width: 20, height: 20)
            .buttonStyle(.plain)
            
            
            Text(task.title)
                .font(.headline)
                .foregroundStyle(task.isCompleted ? .secondary : .primary)
                .padding(.horizontal)
            
            Spacer()
            
            Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(height: 40)
    }
    var filledReminderLabel: some View {
        Circle()
            .stroke(.primary, lineWidth: 2)
            .overlay(alignment: .center) {
                GeometryReader { geo in
                    VStack {
                        Circle()
                            .fill(.primary)
                            .frame(width: geo.size.width*0.7, height: geo.size.height*0.7, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
    }
    
    var emptyReminderLabel: some View {
        Circle()
            .stroke(.secondary)
    }
}

#Preview {
    TaskRowView(task: Tasks(title: "Tarea", createdAt: Date.now))
}
