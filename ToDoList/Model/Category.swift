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
    @Relationship(deleteRule: .cascade) var tasks = [Tasks]()
    
    init(name: String) {
        self.name = name
    }
}
