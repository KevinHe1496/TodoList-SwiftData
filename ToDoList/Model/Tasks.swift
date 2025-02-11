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
    var createdAt: Date
    var category: Category?
    
    init(title: String, createdAt: Date, category: Category? = nil) {
        self.title = title
        self.createdAt = createdAt
        self.category = category
    }
}
