//
//  Category.swift
//  ToDoList
//
//  Created by Kevin Heredia on 10/2/25.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    var iconName: String
    
    @Relationship(deleteRule: .cascade) var tasks = [Tasks]() // relacion con tasks
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
}
