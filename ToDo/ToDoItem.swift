//
//  ToDoItem.swift
//  ToDo
//
//  Created by Jawad Hussain Farooqui on 24/08/20.
//  Copyright © 2020 Winsights. All rights reserved.
//

import Foundation

struct ToDoItem: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var important: Bool
    
    init(title: String, important: Bool) {
        self.title = title
        self.important = important
    }
}

class ToDoStorage: ObservableObject {
    @Published var toDos = [ToDoItem]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(toDos), forKey: "toDos")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.value(forKey: "toDos") as? Data {
            if let userDefaultTodos = try? PropertyListDecoder().decode(Array<ToDoItem>.self, from: data){
                toDos = userDefaultTodos
            }
        }
    }
}
