//
//  Tasks.swift
//  ToDoList
//
//  Created by Kevin Heredia on 10/2/25.
//

import Foundation
import SwiftData

@Model
class Tasks {
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var category: Category?
    
    init(title: String, isCompleted: Bool, createdAt: Date, category: Category? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.category = category
    }
}
